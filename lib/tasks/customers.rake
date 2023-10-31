namespace :csv_load do
  task customers: :environment do
    require "csv"
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Customer.create!(first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
