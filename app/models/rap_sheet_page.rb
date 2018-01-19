class RapSheetPage < ApplicationRecord
  mount_uploader :rap_sheet_page_image, RapSheetPageImageUploader

  def self.scan_and_create(image:, rap_sheet_id:)
    RapSheetPage.create!(
      rap_sheet_page_image: image,
      rap_sheet_id: rap_sheet_id,
      text: self.scan_text(image.path),
    )
  end

  private

  def self.scan_text(image_path)
    RTesseract.new(image_path, processor: 'mini_magick').to_s
  end
end