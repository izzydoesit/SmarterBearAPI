class Transaction < ApplicationRecord
  belongs_to :insider
  belongs_to :company
end
