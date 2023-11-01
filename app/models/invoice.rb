class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  validates :status, presence: true

  enum:status, ["in progress", "completed", "cancelled"]
end