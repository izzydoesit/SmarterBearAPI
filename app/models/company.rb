class Company < ApplicationRecord
  include ApplicationHelper
  
  has_many :insiders
  has_many :transactions, through: :insiders

  validates :name, :cik_number, :ticker, presence: true
 
  # need to add in shares outstanding once data is found 
  def rate_confidence
    self.transactions_this_month.count
  end

  def self.search_by_name(name)
    self.where("name like ?", "#{name.downcase.capitalize[0..3]}%")
  end

  def self.search_by_ticker(ticker)
    self.where("ticker like ?", "#{ticker.upcase[0..3]}%")
  end

  def self.search(param)
    [search_by_name(param), search_by_ticker(param)].flatten.uniq
  end
end
