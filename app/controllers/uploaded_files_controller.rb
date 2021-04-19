class UploadedFilesController < ApplicationController
  require 'csv'
  require "#{Rails.root}/lib/contact_column.rb"
  before_action :authenticate_user!

  def new
    @uploaded_file = UploadedFile.new
  end

  def create
    @uploaded_file = UploadedFile.new(uploaded_file_params)
    @uploaded_file.state = 'ON HOLD'
    @uploaded_file.user_id = current_user.id
    if @uploaded_file.save
      @columns_collection = []
      (Contact.column_names).each do |column|
        item = ContactColumn.new(column,column)
        @columns_collection.push(item)
      end
      @file = UploadedFilePreProcessService.new("#{Rails.root}/public/#{@uploaded_file.file}").execute
    end
  end

  private
    def uploaded_file_params
      params.require(:uploaded_file).permit(:title, :state, :user_id, :file)
    end

end