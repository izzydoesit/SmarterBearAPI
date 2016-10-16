require 'httparty'
require 'dotenv'
Dotenv.load
# Example Edgar-Online query string:
# http://edgaronline.api.mashery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&filter=transactiontype+ne+%22Option+Execute%22&issuenames=%2A[COMPANY NAME]%2A&debug=true&sortby=transactiondate+asc&appkey=[API KEY]



COMPANIES = [
  {name: "Yahoo! Inc", cik_number: 1011006, ticker: "YHOO"},
  {name: "Apple Inc", cik_number: 320193, ticker: "AAPL"},
  {name: "General Motors Company", cik_number: 1467858, ticker: "GM"},
  {name: "Alphabet Inc", cik_number: 1652044, ticker: "GOOGL"},
  {name: "Hewlett Packard", cik_number: 47217, ticker: "HPQ"},
  {name: "Palo Alto Networks INC", cik_number: 1327567, ticker: "PANW"},
  {name: "Facebook", cik_number: 1326801, ticker: "FB"},
  {name: "FedEx", cik_number: 1048911, ticker: "FDX"},
  {name: "Sabre Corp", cik_number: 1597033, ticker: "SABR"},
  {name: "Splunk INC", cik_number: 1353283, ticker: "SPLK"},
  {name: "Coupa Software INC", cik_number: 1385867, ticker: "COUP"},
  {name: "Comcast", cik_number: 1166691, ticker: "CMCSA"},
  {name: "CBS", cik_number: 813828, ticker: "CBS"},
  {name: "International Business Machine", cik_number: 51143, ticker: "IBM"},
  {name: "Panera Bread Co", cik_number: 724606, ticker: "PNRA"}
]

def fetch_json_forms(company_name)
  api_key = ENV["EDGAR_ONLINE_KEY"]
  HTTParty.get("http://edgaronline.api.mashery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&issuenames=%2A#{company_name}%2A&transactiondates=20151016%7E20161015&limit=1000&debug=true&sortby=transactionDate+desc&appkey=#{api_key}")
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

  parse_json_forms(fetch_json_forms(@company.name)).each do |form|

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
  # begin
    xml = File.read("db/raw_xml_form_data/#{form.dcn}.xml")
  # rescue Errno::ENOENT
  #   xml = ""
  # end

  if !xml.empty?
    transactions = form.parse_xml_form(xml, insider_id)

    transactions.each do |trans|
      Transaction.create!(trans)
    end
  end
end
 

