class FailedContact < ApplicationRecord
  self.per_page = 10
  def file_name
    file = UploadedFile.find(self.uploadedfile_id)
    "#{file.file}"
  end
end
