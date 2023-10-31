class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.integer :unit_price
      t.references :merchant, null: false, foreign_key: true
      t.string :created_at
      t.string :updated_at
    end
  end
end
