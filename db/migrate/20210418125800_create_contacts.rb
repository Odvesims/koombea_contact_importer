class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string  :name,          null: false
      t.string  :date_of_birth, null: false
      t.string  :phone,         null: false
      t.string  :address,       null: false
      t.string  :credit_card,   null: false
      t.string  :franchise,     null: false
      t.string  :email,         null: false
      t.string  :card_last4,    null: false
      t.integer :user_id,       null: false
      t.integer :uploadedfile_id 

      t.timestamps
    end
  end
end
