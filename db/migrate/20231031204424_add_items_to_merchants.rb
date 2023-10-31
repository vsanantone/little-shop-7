class AddItemsToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_reference :merchants, :merchant, null: false, foreign_key: true
  end
end
