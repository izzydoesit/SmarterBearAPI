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

  def total_value
    total = 0
    self.transactions.each do |trans|
      trans.direction == "A" ? total += trans.total_value : total -= trans.total_value
    end
    total
  end

  def value_in_dollars(num)
    number_to_currency(num)
  end

  def value_with_commas(num)
    number_with_delimiter(num)
  end
end
