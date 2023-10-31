namespace :csv_load do
  task merchants: :environment do
    require "csv"
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Merchant.create!(name: row["name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
