class CreateCreditCardFranchises < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_card_franchises do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end
