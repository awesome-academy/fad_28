require "carrierwave"

class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  storage :file

  def store_dir
    "uploads/ckeditor/attachments/#{model.id}"
  end

  def extension_white_list
    Ckeditor.attachment_file_types
  end
end
