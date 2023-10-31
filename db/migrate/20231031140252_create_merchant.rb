class CreateMerchant < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.integer :id
      t.string :name

      t.timestamps
  end
end
