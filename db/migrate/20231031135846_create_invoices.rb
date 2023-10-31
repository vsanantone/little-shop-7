class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :id
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.string :created_at
      t.string :updated_at
    end
  end
end
