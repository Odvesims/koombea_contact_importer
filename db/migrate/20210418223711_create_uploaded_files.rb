class CreateUploadedFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :uploaded_files do |t|
      t.string :title
      t.string :state

      t.timestamps
    end
  end
end
