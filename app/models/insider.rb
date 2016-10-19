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
end
