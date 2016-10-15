class Company < ApplicationRecord
  has_many :insiders
  has_many :transactions, through: :insiders

  validates :name, presence: true

  # need to add in shares outstanding and ticker validation once data is found
end
