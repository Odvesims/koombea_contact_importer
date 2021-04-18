class CreateImportedFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :imported_files do |t|
      t.string :name
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
