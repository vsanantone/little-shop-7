namespace :csv_load do
  task items: :environment do
    require "csv"
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Item.create!(name: row["name"], description: row["description"], unit_price: (row["unit_price"].to_f * 100).to_i, merchant_id: row["merchant_id"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
