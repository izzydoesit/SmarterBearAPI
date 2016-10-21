class Company < ApplicationRecord
  include TransactionsHelper
  # include ActionView::Helpers::NumberHelper
  has_one :image
  has_many :insiders
  has_many :transactions, through: :insiders

  validates :name, :cik_number, :ticker, presence: true
 
  # need to add in shares outstanding once data is found 
  def rate_confidence
    self.transactions_this_month.count
  end

  def self.search_by_name(name)
    self.where("name like ?", "#{name.downcase.capitalize[0..3]}%")
  end

  def self.search_by_ticker(ticker)
    self.where("ticker like ?", "#{ticker.upcase[0..3]}%")
  end

  def self.search(param)
    results = []
    [search_by_name(param), search_by_ticker(param)].flatten.uniq.each do |company|
      company_details = {
        id: company.id,
        name: company.name,
        ticker: company.ticker,
        shares_outstanding: company.value_with_commas(company.shares_outstanding),
        confidence: company.confidence_rating,
        transactions_total: company.value_in_dollars(company.trades_total_value),
        insiders: company.insiders.count
      }
      results << company_details
    end
    results
  end

  def transactions_by_direction(dir)
    directional_transactions = []
    self.transactions.each { |trans| directional_transactions << trans if trans.direction == "#{dir}" }
    directional_transactions
  end

  def format_chart_data(dir)
    transactions_by_direction(dir).map { |trans| trans.format_chart_data_point }
  end

  def self.top_5_by_transaction
    self.all.sort_by { |company| company.trades_total_value.abs }.reverse[0..4]
  end

  # Example of data format needed for main page chart
  # 'Facebook': {
  #               'Mark Zuckerberg': {
  #                   '2016-09-22': '500',
  #                   '2016-09-23': '890',
  #                   '2016-09-24': '250'
  #           },
  # 'Apple': {
  #               'Tim Cook': {
  #                   '2016-09-22': '16.8',
  #                   '2016-09-23': '602.8',
  #                   '2016-09-24': '44.3'
  #               }
  #           }
  def self.main_page_chart_data
    data = {}

    top_5_by_transaction.each do |comp| 
      data[comp.name] = {}

      comp.insiders.each do |ins|
        data[comp.name][ins.name] = Hash.new(0)

        ins.transactions.each do |trans|
          data[comp.name][ins.name][trans.date] += trans.total_value.abs

        end
      end
    end
    data
  end
end
