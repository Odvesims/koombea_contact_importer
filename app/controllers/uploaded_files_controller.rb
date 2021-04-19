class UploadedFilesController < ApplicationController
  require 'csv'
  before_action :authenticate_user!

  def new
    @uploaded_file = UploadedFile.new
  end

  def create
    @file_header = Array.new
    @uploaded_file = UploadedFile.new(uploaded_file_params)
    @uploaded_file.state = 'ON HOLD'
    @uploaded_file.user_id = current_user.id
    @uploaded_file.save
    @contact_columns = {}
    CSV.foreach("#{Rails.root}/public/#{@uploaded_file.file}") do |row|
      @file_header.push(row)
      break
    end
    @file_header = @file_header[0]
  end

  private
    def uploaded_file_params
      params.require(:uploaded_file).permit(:title, :state, :user_id, :file)
    end

end