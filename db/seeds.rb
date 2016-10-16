require 'httparty'
require 'dotenv'
Dotenv.load
# Example Edgar-Online query string:
# http://edgaronline.api.mashery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&filter=transactiontype+ne+%22Option+Execute%22&issuenames=%2A[COMPANY NAME]%2A&debug=true&sortby=transactiondate+asc&appkey=[API KEY]

COMPANY_CIK_NUMS = {
  "yahoo" => 1011006,
  "apple" => 320193,
  "gm" => 1467858,
  "alphabet" => 1652044,
  "hewlett packard" => 47217,
  "palo alto networks inc" => 1327567,
  "facebook" => 1326801,
  "fedex" => 1048911,
  "sabre corp" => 1597033,
  "splunk inc" => 1353283,
  "coupa software inc" => 1385867,
  "comcast" => 1166691,
  "cbs" => 813828,
  "international business machine" => 51143,
  "panera" => 724606
}

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

COMPANY_CIK_NUMS.each do |company_name, cik|
  Company.create!(name: "#{company_name}", cik_number: cik)
  
  @company = Company.find_by(name: "#{company_name}")

  parse_json_forms(fetch_json_forms(company_name)).each do |form|

    if !Insider.find_by(name: form["filername"])
      
      Insider.create!(name: form["filername"], 
              relationship: form["relationship"], 
                company_id: @company.id)

      @insider = Insider.find_by(name: form["filername"])
    end

    Form.create!(date: form["transactiondate"],
                  dcn: form["dcn"],
         sec_form_url: "ftp://ftp.sec.gov/edgar/data/#{cik}/#{form['dcn']}.txt",
           insider_id: @insider.id)
  end
end

Form.all.each do |form|
  insider_id = form.insider.id
  xml = form.fetch_xml_form

  if xml
    transactions = parse_xml_form

    transactions.each do |trans|
      Transaction.create!(trans)
    end
  end
end
 

