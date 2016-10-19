require 'nokogiri'
require 'net/ftp'
require 'fileutils'

class Form < ApplicationRecord
  include FileUtils

  belongs_to :insider
  has_many :transactions

  def fetch_xml_form
    ftp = Net::FTP.new('ftp.sec.gov')
    ftp.login
    ftp.chdir("edgar/data/#{self.insider.company.cik_number}")
    begin
      form = ftp.getbinaryfile("#{self.dcn}.txt", "#{self.dcn}.xml")
    rescue Net::FTPPermError
      form = nil
    rescue Net::ReadTimeout
      form = nil
    end
    ftp.close
    form
  end


  def parse_xml_form(form, insider_id, form_id)
    prices = []
    dates = []
    directions = []
    shares = []
    form_transactions = []

    doc = Nokogiri::XML(form)

    doc.search('//transactionPricePerShare').each do |price|
      if price.at('value')
        prices << price.at('value').text
      end
    end

    doc.search('//transactionDate').each do |date|
      if date.at('value') 
        dates << date.at('value').text
      end
    end

    doc.search('//transactionAcquiredDisposedCode').each do |direction|
      if direction.at('value')
        directions << direction.at('value').text
      end
    end

    doc.search('//transactionShares').each do |share|
      if share.at('value')
        shares << share.at('value').text
      end
    end

    prices.each_with_index do |price, idx|
      transaction ={
        price_per_share: price,
        date: dates[idx],
        direction: directions[idx],
        shares_transacted: shares[idx],
        insider_id: insider_id,
        company_id: Insider.find(insider_id).company.id,
        form_id: form_id
      }

      transaction[:total_value] = total_transaction_value(transaction[:price_per_share], transaction[:shares_transacted])

      form_transactions << transaction
    end
    return form_transactions
  end

  def total_transaction_value(pps, share_count)
    pps.to_f * share_count.to_i
  end
end