class CatImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick  # Include the MiniMagick module

  storage :fog

  # Process files as they are uploaded:
  process resize_to_fit: [800, 800]

  # Create different versions of your uploaded files:
  version :thumb_small do
    process resize_to_fill: [50, 50]
  end

  version :thumb_medium do
    process resize_to_fill: [100, 100]
  end

  version :thumb_large do
    process resize_to_fill: [225, 225]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w[jpg jpeg gif png webp]
  end
end
