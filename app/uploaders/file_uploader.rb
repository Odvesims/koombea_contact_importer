class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_allowlist
    %w(csv)
  end

  def store_dir
    if Rails.env.production?
      '../app/public/uploads'
    else
      'uploads'
    end
  end
end
