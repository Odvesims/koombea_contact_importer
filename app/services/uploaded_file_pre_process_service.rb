class UploadedFilePreProcessService

  attr_accessor :file_header, :file_path

  def initialize(file_path)
    @file_path = file_path
    @file_header = []
  end

  def execute() 
    CSV.foreach(file_path) do |row|
      file_header.push(row)
      break
    end
    @file_header = file_header[0]
  end
end