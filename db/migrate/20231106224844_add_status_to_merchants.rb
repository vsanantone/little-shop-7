class AddStatusToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :enabled, :boolean, default: false
  end
end

