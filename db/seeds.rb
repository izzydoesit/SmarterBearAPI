require 'httparty'

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

def fetch_transactions_json(company_name)
  HTTParty.get("http://edgaronline.api.mash ery.com/v2/insiders/transactions?fields=%21filerCity%2C%21filerStateid%2C%21filerState%2C%21filerZip%2C%21filerPhone%2C%21issueCity%2C%21issueStateid%2C%21issueState%2C%21issueZip&filter=transactiontype+ne+%22Option+Execute%22&issuenames=%2A#{company_name}%2A&debug=true&sortby=transactiondate+asc&appkey=[API_KEY]")
end

def parse_transactions(all_transactions)
  transaction_data = []
  
  all_transactions["result"]["rows"].each do |transaction|
    parsed_transaction = {}
    
    transaction["values"].each do |val|
      parsed_transaction[val["field"]] = val["value"]
    end
    
    transaction_data << parsed_transaction
  
  end
  transaction_data
end

COMPANY_CIK_NUMS.each do |name, cik|
  Company.create!(name: "#{name}", cik_number: cik)
end 

# parse_transactions(fetch_transactions_json(name))

