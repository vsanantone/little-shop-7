class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.string :created_at
      t.string :updated_at
    end
  end
end
