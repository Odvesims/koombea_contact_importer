class ProcessFileWorker
  include Sidekiq::Worker
  require 'csv'
  sidekiq_options retry: false
  sidekiq_options retry: 0

  def perform(file_id, columns_order, user_id)
    file = UploadedFile.find(file_id)
    file.state = "PROCESSING"
    file.file = file.main_file.filename.to_s
    file.save
    i = 0
    CSV.parse(file.main_file.download) do |row|
      if i > 0
        row_arr = row.split(",")
        row_arr = row_arr[0]
        name = row_arr[columns_order.index("name")]
        date_of_birth = row_arr[columns_order.index("date_of_birth")]
        phone = row_arr[columns_order.index("phone")]
        address = row_arr[columns_order.index("address")]
        credit_card = row_arr[columns_order.index("credit_card")]
        email = row_arr[columns_order.index("email")]
        CreateContactWorker.perform_async(name, date_of_birth, phone, address, credit_card, email, file_id, i, user_id)
      end
      i += 1
    end
    sleep 3
    contacts = Contact.where("uploadedfile_id = #{file_id}").all
    if contacts.count > 0 or (i == 1)
      file.state = "FINISHED" 
    else
      file.state = "FAILED"
    end
    file.save
  end
end
