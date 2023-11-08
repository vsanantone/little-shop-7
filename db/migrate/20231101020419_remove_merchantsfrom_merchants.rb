class RemoveMerchantsfromMerchants < ActiveRecord::Migration[7.0]
  def change
    remove_column :merchants, :merchant_id
  end
end
