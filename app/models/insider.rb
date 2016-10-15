class Insider < ApplicationRecord
  has_many :forms
  has_many :transactions
  belongs_to :company
end
