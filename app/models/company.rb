class Company < ApplicationRecord
  include ApplicationHelper
  
  has_many :insiders
  has_many :transactions, through: :insiders

  validates :name, :cik_number, :ticker, presence: true

  # need to add in shares outstanding once data is found
  def rate_confidence
    self.transactions_this_month.count
  end
end
