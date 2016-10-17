class Company < ApplicationRecord
  has_many :insiders
  has_many :transactions, through: :insiders

  validates :name, :cik_number, :ticker, presence: true

  # need to add in shares outstanding once data is found
  def transactions_this_month
    transactions = []
    
    self.transactions.each do |trans|
    transactions << trans if this_month?(trans)
    end

    transactions
  end

  def this_month?(trans)
    return false if trans.date[0..3].to_i != Time.new.year
    return false if trans.date[5..6].to_i != Time.new.month #|| ( Time.new.month - trans.date[5..6].to_i ) > 1
    true
  end
end
