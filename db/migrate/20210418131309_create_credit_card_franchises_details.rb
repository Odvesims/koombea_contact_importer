class CreateCreditCardFranchisesDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_card_franchises do |t|
      t.integer :name,             null:false
      t.string  :iin_range,        null:false
      t.integer :characters_count, null:false
      t.string  :length_range,     null:false

      t.timestamps
    end
  end
end
