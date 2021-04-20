class UploadedFilesController < ApplicationController
  require 'csv'
  require "#{Rails.root}/lib/contact_column.rb"
  before_action :authenticate_user!
  VALID_COLUMNS = ["name", "date_of_birth", "phone", "address", "credit_card", "email", "lastname"]

  def index
    @uploaded_files = UploadedFile.where(:user_id => current_user.id).paginate(:page => params[:page]).order('id DESC')
  end

  def new
    @uploaded_file = UploadedFile.new
  end

  def show
    uploaded_file
  end

  def create
    @uploaded_file = UploadedFile.new(uploaded_file_params)
    @uploaded_file.state = 'ON HOLD'
    @uploaded_file.user_id = current_user.id
    if @uploaded_file.save
      uploaded_file(@uploaded_file.id)
    end
  end

  def process_file
    columns_order = []
    file_columns = []
    params[:uploaded_files]["contact_columns"].each do |key, value|
      columns_order.push(value.gsub(" ", ""))
    end
    params[:uploaded_files]["file_colums"].each do |key, value|
      file_columns.push(value.gsub(" ", ""))
    end
    file_id = params[:file_id]
    columns_order.uniq!
    if columns_order.count != file_columns.count
      uploaded_file(file_id)
      flash[:notice] = 'You made a mistake while selecting the columns. Try again.'
      render 'show'
    end
    ProcessFileWorker.perform_async(file_id, columns_order, current_user.id)
  end

  private
    def uploaded_file_params
      params.require(:uploaded_file).permit(:title, :state, :user_id, :file, :main_file)
    end

    def uploaded_file(uploaded_file_id)
      @file_id = uploaded_file_id
      @columns_collection = []
      (Contact.column_names).each do |column|
        item = ContactColumn.new(column,column)
        @columns_collection.push(item) if VALID_COLUMNS.include? column  
      end
      @file = UploadedFilePreProcessService.new(@file_id).execute
      if @file.count != @columns_collection.count
        flash[:notice] = 'The number of columns is not valid.'
        redirect_to new_uploaded_file_path
      end
    end

end