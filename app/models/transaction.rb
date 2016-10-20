class Transaction < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :insider
  belongs_to :company
  belongs_to :form

# example of data format needed for chart:
  # x = shares_outstanding, y = insider_score, z = total_transaction_value
  # series: [{
  #           data: [
  #               { x: 142084800000, y: 10, z: 1500000, name: 'KEOUGH TRACY S', relationship: "Officer", shares: 100000 , pps: 15 },
  #               { x: 142084800000, y: 10, z: 1500000, name: 'KEOUGH TRACY S', relationship: "Officer", shares: 100000 , pps: 15 }
  #           ]

  def format_chart_data_point
    data_point = { x: self.date_in_milliseconds.to_i,
             y: self.total_value,
             z: self.insider.insider_score,
          name: self.insider.name,
  relationship: self.insider.relationship,
        shares: self.shares_transacted,
           pps: number_to_currency(self.price_per_share),
   date_string: DateTime.new(self.date[0..3].to_i,self.date[5..6].to_i,self.date[8..9].to_i).strftime('%m-%d-%Y')
      }
  end


  def date_in_milliseconds
    date = DateTime.new(self.date[0..3].to_i,self.date[5..6].to_i,self.date[8..9].to_i)
    date.strftime('%Q')
  end
end