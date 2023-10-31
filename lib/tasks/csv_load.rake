namespace :csv_load do
  task all:   [
    "csv_load:merchants",
    "csv_load:items",
    "csv_load:customers",
    "csv_load:invoices",
    "csv_load:transactions",
    "csv_load:invoice_items"
  ]
end
