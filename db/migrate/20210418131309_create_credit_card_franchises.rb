class CreateCreditCardFranchises < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_card_franchises do |t|
      t.string :name
      t.string :iin_ranges
      t.integer :min_length
      t.integer :max_length

      t.timestamps
    end
  end
end
