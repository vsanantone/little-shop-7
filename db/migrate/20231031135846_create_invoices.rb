class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :id
      t.references :customer, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
