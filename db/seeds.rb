require 'httparty'
require 'dotenv'
Dotenv.load
# Example Edgar-Online query string:
# http://edgaronline.api.mashery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&filter=transactiontype+ne+%22Option+Execute%22&issuenames=%2A[COMPANY NAME]%2A&debug=true&sortby=transactiondate+asc&appkey=[API KEY]



COMPANIES = [
  {name: "Yahoo Inc", cik_number: 1011006, ticker: "YHOO", shares_outstanding: 951782587},
  {name: "Apple Inc", cik_number: 320193, ticker: "AAPL", shares_outstanding: 5388443000},
  {name: "Ruby Tuesday", cik_number: 1568681, ticker: "RT", shares_outstanding: 60196759},
  {name: "Google Inc", cik_number: 1652044, ticker: "GOOGL", shares_outstanding: 687273797},
  {name: "Hewlett Packard", cik_number: 47217, ticker: "HPQ", shares_outstanding: 1710875682},
  {name: "Palo Alto Networks INC", cik_number: 1327567, ticker: "PANW", shares_outstanding: 90850457},
  {name: "Facebook", cik_number: 1326801, ticker: "FB", shares_outstanding: 2871664261},
  {name: "FedEx", cik_number: 1048911, ticker: "FDX", shares_outstanding: 265759372},
  {name: "Sabre Corp", cik_number: 1597033, ticker: "SABR", shares_outstanding: 278069943},
  {name: "Splunk INC", cik_number: 1353283, ticker: "SPLK", shares_outstanding: 134543363},
  {name: "Coupa Software INC", cik_number: 1385867, ticker: "COUP", shares_outstanding: 48110957},
  {name: "Comcast", cik_number: 1166691, ticker: "CMCSA", shares_outstanding: 2411825686},
  {name: "CBS", cik_number: 813828, ticker: "CBS", shares_outstanding: 444601753},
  {name: "International Business Machine", cik_number: 51143, ticker: "IBM", shares_outstanding: 955844217},
  {name: "Panera Bread Co", cik_number: 724606, ticker: "PNRA", shares_outstanding: 23646377}
]

def fetch_json_forms(company_ticker)
  api_key = ENV["EDGAR_ONLINE_KEY"]
  HTTParty.get("http://edgaronline.api.mashery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&issuetickers=#{company_ticker}&transactiondates=20160616%7E20161015&limit=1000&debug=true&sortby=transactionDate+desc&appkey=#{api_key}")
end

def parse_json_forms(all_forms)
  form_data = []
  
  all_forms["result"]["rows"].each do |form|
    parsed_form = {}
    
    form["values"].each do |val|
      parsed_form[val["field"]] = val["value"]

    end
    form_data << parsed_form

  end
  form_data
end

COMPANIES.each do |company|
  Company.create!(company)
  
  @company = Company.find_by(name: "#{company[:name]}")

  parse_json_forms(fetch_json_forms(@company.ticker)).each do |form|

    if !Insider.find_by(name: form["filername"])
      
      Insider.create!(name: form["filername"], 
              relationship: form["relationship"], 
                company_id: @company.id)

      @insider = Insider.find_by(name: form["filername"])
    end

    Form.create!(date: form["transactiondate"],
                  dcn: form["dcn"],
         sec_form_url: "ftp://ftp.sec.gov/edgar/data/#{@company.cik_number}/#{form['dcn']}.txt",
           insider_id: @insider.id)
  end
end

Form.all.each do |form|
  insider_id = form.insider.id
  xml = File.read("db/raw_xml_form_data/#{form.dcn}.xml")

  if !xml.empty?
    transactions = form.parse_xml_form(xml, insider_id)

    transactions.each do |trans|
      Transaction.create!(trans)
    end
  end
end

Company.all.each { |company| company.update!(confidence_rating: company.rate_confidence) }