class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.app.uploaders.picture.size,
                            Settings.app.uploaders.picture.size]
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url *_args
    "/upload/#{model.class.to_s.underscore}/image/image-#{rand(1..10)}.jpg"
  end
end
