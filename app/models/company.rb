class Company < ApplicationRecord
  validates name, ticker, shares_outstanding, presence: true
end
