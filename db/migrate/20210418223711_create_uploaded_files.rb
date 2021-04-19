class CreateUploadedFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :uploaded_files do |t|
      t.string  :title, null:false
      t.string  :state, null:false
      t.integer :user_id, null:false
      t.string  :file, null:false

      t.timestamps
    end
  end
end
