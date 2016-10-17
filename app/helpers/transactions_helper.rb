module TransactionsHelper
  include ActionView::Helpers::NumberHelper

  def transactions_this_month
    transactions = []
    
    self.transactions.each do |trans|
    transactions << trans if this_month?(trans)
    end

    transactions
  end

  def this_month?(trans)
    return false if trans.date[0..3].to_i != Time.new.year
    return false if trans.date[5..6].to_i != Time.new.month #|| ( Time.new.month - trans.date[5..6].to_i ) > 1
    true
  end

  def transactions_this_month_total_value
    total = 0
    self.transactions_this_month.map do |trans|
      trans.direction == "A" ? total += trans.total_value : total -= trans.total_value
    end
    number_to_currency(total)
  end
end
