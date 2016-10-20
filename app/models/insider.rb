class Insider < ApplicationRecord
  include TransactionsHelper

  has_many :forms
  has_many :transactions
  belongs_to :company

  def give_insider_score
    case self.relationship
      when "Officer"
        self.insider_score = 10
      when "Director"
        self.insider_score = 6
      when "Beneficial Owner (10%)"
        self.insider_score = 3
      else
        self.insider_score = 2
    end
  end

  def self.top_5_by_transaction_count
    self.all.sort_by { |insider| insider.transactions.count }.reverse[0..4]
  end

  def self.main_page_chart_data
    insider_data = {}

    top_5_by_transaction_count.each do |ins| 
        insider_data["#{ins.name}"] = {}
        
        ins.transactions.each do |trans|
          insider_data["#{ins.name}"]["#{trans.date}"] = trans.total_value
        end
      end
      insider_data
    end
end
