class CreateFailedContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :failed_contacts do |t|
      t.integer :user_id,       null:false
      t.string  :file_name,     null:false
      t.integer :file_line,      null:false
      t.string  :contact_name,  null:false
      t.string   :error_message, null:false

      t.timestamps
    end
  end
end
