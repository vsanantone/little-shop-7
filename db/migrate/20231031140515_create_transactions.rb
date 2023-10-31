class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :id
      t.references :invoice, null: false, foreign_key: true
      t.integer :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result
      t.string :created_at
      t.string :updated_at
    end
  end
end
