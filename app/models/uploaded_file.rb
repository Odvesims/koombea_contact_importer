class UploadedFile < ApplicationRecord
  has_one_attached :main_file
end
