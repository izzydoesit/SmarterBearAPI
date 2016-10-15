require 'nokogiri'
require 'net/ftp'
class Form < ApplicationRecord
  belongs_to :insider

  def fetch_form
    ftp = Net::FTP.new('ftp.sec.gov')
    ftp.login
    ftp.chdir("edgar/data/#{self.insider.company.cik_number}")
    form = ftp.getbinaryfile("#{self.dcn}.txt", nil)
    ftp.close
    form
    # find_share_transaction_count(form)
  end

  def parse_form(form)
    transaction = {}
    form_transactions = []
    Nokogiri::XML(form).search('//nonDerivativeTransaction').each do |trans|
      
    end
  end
end
