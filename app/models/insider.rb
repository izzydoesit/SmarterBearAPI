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
        insider_data["#{ins.name}"] = {
                  name: ins.name,
               company: ins.company.name,
              position: ins.relationship,
          total_trades: ins.transactions.count,
     total_trade_value: ins.number_to_currency(ins.trades_total_value)
        }
      end
      insider_data
    end

    def format_name
      formatted_name = self.name.split.map! { |n| n.downcase.capitalize }
      last_name = "jeff"
    end
end
