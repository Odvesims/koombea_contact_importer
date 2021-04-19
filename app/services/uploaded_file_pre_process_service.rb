class UploadedFilePreProcessService

  attr_accessor :file_header, :file_id

  def initialize(file_id)
    @file_id = file_id
    @file_header = []
  end

  def execute() 
    uploaded_file = UploadedFile.find(file_id)
    CSV.parse(uploaded_file.main_file.download) do |row|
      file_header.push(row)
    end
    @file_header = file_header[0]
  end
end