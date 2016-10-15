class Insider < ApplicationRecord
  has_many :transactions
  belongs_to :company
end
