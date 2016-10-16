class Transaction < ApplicationRecord
  belongs_to :insider
  belongs_to :company
  belongs_to :form
end
