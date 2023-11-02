namespace :csv_load do
  task transactions: :environment do
    require "csv"
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, headers: true) do |row|
      result = case row["result"].strip.downcase
      when "success"
        "success"
      when "failed"
        "failed"
      else
        "failed"
      end
      Transaction.create!(invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], credit_card_expiration_date: row["credit_card_expiration_date"], result: result, created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
