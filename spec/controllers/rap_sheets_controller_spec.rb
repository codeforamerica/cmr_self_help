require 'rails_helper'

RSpec.describe RapSheetsController, type: :controller do
  describe '#create' do
    it 'creates with supplied params' do
      post :create, params: {
        rap_sheet: {
          number_of_pages: 2
        }
      }

      expect(RapSheet.last.number_of_pages).to eq(2)
    end

    it 'creates the associated user' do
      expect do
        post :create, params: {
          rap_sheet: {
            number_of_pages: 2
          }
        }
      end.to change(User, :count).by(1)

      expect(RapSheet.last.user).to be
    end
  end

  describe '#show' do
    render_views

    let(:text) do
      <<~TEXT
        info
        * * * *
        COURT:
        19740102 CASC SAN PRANCISCU rm

        CNT: 001 #123
        DISPO:DISMISSED
        * * * END OF MESSAGE * * *
      TEXT
    end

    let(:rap_sheet) do
      create(:rap_sheet,
             number_of_pages: 1,
             rap_sheet_pages: [RapSheetPage.new(text: text, page_number: 1)]
      )
    end

    it 'alerts the user if no convictions are found' do
      get :show, params: { id: rap_sheet.id }

      expect(response).to redirect_to(no_convictions_rap_sheet_path(rap_sheet.id))
    end

    context 'there is a eligible p64 conviction' do
      let(:text) { single_conviction_rap_sheet('11357 HS-POSSESS MARIJUANA') }

      it 'shows the eligible conviction details' do
        get :show, params: { id: rap_sheet.id }

        expect(response.body).to include('We found 1 conviction that may be eligible for record clearance.')
        expect(response.body).to include('p64')
        expect(response.body).to include('1984-09-18')
        expect(response.body).to include('M')
        expect(response.body).to include('CASC Los Angeles')
        expect(response.body).to include('HS 11357')
        expect(response.body).to include('#1234567')
      end
    end

    context 'there are eligible 1203.4 convictions' do
      let(:text) { single_conviction_rap_sheet('496 PC-RECEIVE/ETC KNOWN STOLEN PROPERTY') }

      it 'shows the eligible conviction details' do
        get :show, params: { id: rap_sheet.id }

        expect(response.body).to include('We found 1 conviction that may be eligible for record clearance.')
        expect(response.body).to include('1203.4 mand')
        expect(response.body).to include('1984-09-18')
        expect(response.body).to include('M')
        expect(response.body).to include('CASC Los Angeles')
        expect(response.body).to include('PC 496')
        expect(response.body).to include('#1234567')
      end

      it 'does not show remedies that the user is not eligible for' do
        get :show, params: { id: rap_sheet.id }

        expect(response.body).not_to include('Prop 64')
      end
    end

    context 'when there are convictions, but none are eligible' do
      let(:text) do
        single_ineligible_conviction_rap_sheet('496 PC-RECEIVE/ETC KNOWN STOLEN PROPERTY')
      end

      it 'shows the rap sheet transcript, but changes the header copy' do
        get :show, params: { id: rap_sheet.id }

        expect(response.body).to include('x')
        expect(response.body).to include('2017-09-18')
        expect(response.body).to include('M')
        expect(response.body).to include('CASC Los Angeles')
        expect(response.body).to include('PC 496')
        expect(response.body).to include('#1234567')
        expect(response.body).to include('We found no convictions eligible for relief at this time.')
      end
    end


    context 'when the rap sheet cannot be parsed' do
      before do
        allow_any_instance_of(RapSheet).to receive(:parsed).and_raise(RapSheetParser::RapSheetParserException.new(nil, nil))
      end

      let(:rap_sheet) { create(:rap_sheet) }

      it 'redirects to the debug page' do
        capture_output do
          get :show, params: { id: rap_sheet.id }
        end

        expect(response).to redirect_to(debug_rap_sheet_path(rap_sheet.id))
      end
    end

  end

  describe '#debug' do
    render_views

    describe 'when the rap sheet cannot be parsed' do
      let(:rap_sheet) do
        create(:rap_sheet,
               number_of_pages: 1,
               rap_sheet_pages: [RapSheetPage.new(text: "fancy fjord\n", page_number: 1)]
        )
      end

      it 'shows a stack trace and the page content' do
        capture_output do
          get :debug, params: { id: rap_sheet.id }
        end

        expect(response.body).to include('fancy fjord')
      end
    end
  end

  describe '#add_page' do
    it 'increments the page count' do
      rap_sheet = create(:rap_sheet, number_of_pages: 2)
      expect do
        put :add_page, params: { id: rap_sheet.id }
      end.to change { rap_sheet.reload.number_of_pages }.from(2).to(3)
    end
  end

  describe '#remove_page' do
    context 'when there is only one page' do
      it 'does nothing' do
        rap_sheet = create(:rap_sheet, number_of_pages: 1)
        expect do
          put :remove_page, params: { id: rap_sheet.id }
        end.not_to change { rap_sheet.reload.number_of_pages }
      end
    end

    context 'when a last page has not been uploaded' do
      it 'decrements the page count' do
        rap_sheet = create(:rap_sheet, number_of_pages: 2)
        expect do
          put :remove_page, params: { id: rap_sheet.id }
        end.to change { rap_sheet.reload.number_of_pages }.from(2).to(1)
      end
    end

    context 'when there is an image uploaded for the last page' do
      it 'deletes the last page and decrements the page count' do
        rap_sheet = create(:rap_sheet,
                           number_of_pages: 2,
                           rap_sheet_pages: [
                             RapSheetPage.new(text: 'sample_text', page_number: 1),
                             RapSheetPage.new(text: 'sample_text', page_number: 2)
                           ]
        )
        expect do
          put :remove_page, params: { id: rap_sheet.id }
        end.to change { rap_sheet.reload.number_of_pages }.from(2).to(1)
        expect(rap_sheet.rap_sheet_pages.length).to eq(1)
        expect(rap_sheet.rap_sheet_pages.first.page_number).to eq(1)
      end
    end
  end

  def single_conviction_rap_sheet(conviction_description, sentence: '012 MONTHS PROBATION, 045 DAYS JAIL', severity: 'MISDEMEANOR')
    <<~EOT
      info
      * * * *
      COURT:                NAM:01
      19840918  CASC LOS ANGELES
      
      CNT:01     #1234567
        #{conviction_description}
      *DISPO:CONVICTED
         CONV STATUS:#{severity}
         SEN: #{sentence}      

      *    *    *    END OF MESSAGE    *    *    *
    EOT
  end

  def single_ineligible_conviction_rap_sheet(conviction_description, sentence: '20 YEARS PROBATION, 045 DAYS JAIL', severity: 'MISDEMEANOR')
    <<~EOT
      info
      * * * *
      COURT:                NAM:01
      20170918  CASC LOS ANGELES
      
      CNT:01     #1234567
        #{conviction_description}
      *DISPO:CONVICTED
         CONV STATUS:#{severity}
         SEN: #{sentence}      

      *    *    *    END OF MESSAGE    *    *    *
    EOT
  end
end
