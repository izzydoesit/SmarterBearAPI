require 'nokogiri'
require 'net/ftp'
class Transaction < ApplicationRecord
  belongs_to :insider

  def fetch_transaction_form(cik, dcn)
    ftp = Net::FTP.new('ftp.sec.gov')
    ftp.login
    ftp.chdir("edgar/data/#{cik}")
    ftp.getbinaryfile("#{dcn}.txt", "form.xml")
  end
end
