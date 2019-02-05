require 'rails_helper'

RSpec.describe PC1203PetitionCreator do
  let(:has_attorney) { true }
  let(:dob) { Date.parse('1970-01-01') }
  let(:user) do
    create(:user,
           name: 'Test User',
           date_of_birth: dob,
           street_address: '123 Fake St',
           city: 'San Francisco',
           state: 'CA',
           zip: '12345',
           phone_number: '000-111-2222',
           email: 'me@me.com',
           has_attorney: has_attorney
    )
  end
  let(:rap_sheet) { create(:rap_sheet, user: user) }

  context 'when the client has an attorney' do
    let(:attorney) do
      create(:attorney,
             name: 'Ms. Attorney',
             state_bar_number: '1234567',
             firm_name: 'The Firm',
             street_address: '555 Main Street',
             city: 'Tulsa',
             state: 'OK',
             zip: '55555',
             phone_number: '5555555555',
             email: 'email@example.com'
      )
    end

    before do
      user.update(attorney: attorney)
    end

    it 'creates a filled-out form with the attorney info' do
      conviction_counts = [
        build_count(
          disposition: build_disposition(sentence: RapSheetParser::ConvictionSentence.new(probation: 1.year), severity: 'F'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '111'
        )
      ]
      conviction_event = build_court_event(
        case_number: '#ABCDE',
        date: Date.new(2010, 1, 1),
        courthouse: 'CASC SAN FRANCISCO',
        counts: conviction_counts
      )
      remedy_details = { code: '1203.41' }

      pdf_file = PC1203PetitionCreator.new(
        rap_sheet: rap_sheet,
        conviction_event: conviction_event,
        conviction_counts: conviction_counts,
        remedy_details: remedy_details
      ).create_petition
      expected_values = {
        'Field1' => 'Ms. Attorney    State Bar No: 1234567',
        'Field11' => user.name,
        'Field3' => attorney.street_address,
        'Field12' => '01/01/1970',
        'Field4' => attorney.city,
        'Field5' => attorney.state,
        'Field6' => attorney.zip,
        'Field7' => attorney.phone_number,
        'Field9' => attorney.email,
        'Field10' => user.name,
        'Field2' => 'The Firm',
        'Field13' => '#ABCDE',
        'Field17' => '01/01/2010',
        'Field57' => 'Yes',
        'Field74' => user.street_address,
        'Field75' => 'San Francisco, CA  12345'
      }
      expect(get_fields_from_pdf(pdf_file)).to include(expected_values)
    end

    it 'fills out the offenses table with data from each count' do
      sentence = RapSheetParser::ConvictionSentence.new(probation: nil)
      conviction_counts = [
        build_count(
          disposition: build_disposition(sentence: sentence, severity: 'F'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '107' # wobbler, felony
        ),
        build_count(
          disposition: build_disposition(sentence: sentence, severity: 'M'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '12355(b)' # wobbler but already misdemeanor
        ),
        build_count(
          disposition: build_disposition(sentence: sentence, severity: 'F'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '605' # made up (not a wobbler)
        ),
        build_count(
          disposition: build_disposition(sentence: sentence, severity: 'M'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '330' # reducible to infraction
        )
      ]
      conviction_event = build_court_event(
        case_number: '#ABCDE',
        date: Date.parse('2010-01-01'),
        counts: conviction_counts
      )

      pdf_file = PC1203PetitionCreator.new(
        rap_sheet: rap_sheet,
        conviction_event: conviction_event,
        conviction_counts: conviction_counts,
        remedy_details: nil
      ).create_petition
      expected_values = {
        'Field18' => 'PC',
        'Field19' => '107',
        'Field20' => 'felony',
        'Field21' => 'yes',
        'Field22' => 'no',

        'Field23' => 'PC',
        'Field24' => '12355(b)',
        'Field25' => 'misdemeanor',
        'Field26' => 'no',
        'Field27' => 'no',

        'Field28' => 'PC',
        'Field29' => '605',
        'Field30' => 'felony',
        'Field31' => 'no',
        'Field32' => 'no',

        'Field33' => 'PC',
        'Field34' => '330',
        'Field35' => 'misdemeanor',
        'Field36' => 'no',
        'Field37' => 'yes'
      }

      expect(get_fields_from_pdf(pdf_file)).to include(expected_values)
    end
  end

  context 'when the client is filing pro se' do
    let(:has_attorney) { false }

    it 'creates a filled-out form with client info' do
      conviction_counts = [
        build_count(
          disposition: build_disposition(sentence: RapSheetParser::ConvictionSentence.new(probation: 1.year), severity: 'F'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '111'
        )
      ]
      conviction_event = build_court_event(
        case_number: '#ABCDE',
        date: Date.new(2010, 1, 1),
        courthouse: 'CASC SAN FRANCISCO',
        counts: conviction_counts
      )
      remedy_details = { code: '1203.41' }

      pdf_file = PC1203PetitionCreator.new(
        rap_sheet: rap_sheet,
        conviction_event: conviction_event,
        conviction_counts: conviction_counts,
        remedy_details: remedy_details
      ).create_petition
      expected_values = {
        'Field1' => 'Test User',
        'Field11' => 'Test User',
        'Field3' => '123 Fake St',
        'Field12' => '01/01/1970',
        'Field4' => 'San Francisco',
        'Field5' => 'CA',
        'Field6' => '12345',
        'Field7' => '000-111-2222',
        'Field9' => 'me@me.com',
        'Field10' => 'PRO-SE',
        'Field2' => '',
        'Field13' => '#ABCDE',
        'Field17' => '01/01/2010',
        'Field57' => 'Yes',
        'Field74' => user.street_address,
        'Field75' => 'San Francisco, CA  12345'
      }
      expect(get_fields_from_pdf(pdf_file)).to include(expected_values)
    end
  end
  context 'if dob is empty' do
    let(:dob) {}
    let(:has_attorney) { false }

    it 'returns dob as nil' do
      conviction_counts = [
        build_count(
          disposition: build_disposition(sentence: RapSheetParser::ConvictionSentence.new(probation: 1.year), severity: 'F'),
          code_section_description: 'RECEIVE/ETC KNOWN STOLEN PROPERTY',
          code: 'PC',
          section: '111'
        )
      ]
      conviction_event = build_court_event(
        case_number: '#ABCDE',
        date: Date.new(2010, 1, 1),
        courthouse: 'CASC SAN FRANCISCO',
        counts: conviction_counts
      )
      remedy_details = { code: '1203.41' }

      pdf_file = PC1203PetitionCreator.new(
        rap_sheet: rap_sheet,
        conviction_event: conviction_event,
        conviction_counts: conviction_counts,
        remedy_details: remedy_details
      ).create_petition
      expected_values = {
        'Field12' => ''
      }
      expect(get_fields_from_pdf(pdf_file)).to include(expected_values)
    end
  end
end
