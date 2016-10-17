class Insider < ApplicationRecord
  include TransactionsHelper
  
  has_many :forms
  has_many :transactions
  belongs_to :company
end
