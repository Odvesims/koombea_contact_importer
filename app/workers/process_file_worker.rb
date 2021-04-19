class ProcessFileWorker
  include Sidekiq::Worker
  require 'csv'
  sidekiq_options retry: false
  sidekiq_options retry: 0

  def perform(file_id, columns_order, user_id)
    file = UploadedFile.find(file_id)
    file_path = "#{Rails.root}/public#{file.file}"
    "puts #{file_path}"
    file.state = "PROCESSING"
    file.save
    i = 0
    CSV.foreach(file_path) do |row|
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
    contacts = Contact.where("uploadedfile_id = #{file_id}").all
    sleep 1
    if contacts.count > 0 or (i == 1)
      file.state = "FINISHED" 
    else
      file.state = "FAILED"
    end
    file.save
  end
end
