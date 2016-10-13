require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { Company.create!(name: 'Google, Inc.', ticker: 'GOOG', shares_outstanding: 1000000000) }


  it "has a name" do
    expect(company.name).to eq('Google, Inc.')
  end

  it "has a ticker symbol" do
    expect(company.ticker).to eq('GOOG')
  end

  it "has a number of shares outstanding" do
    expect(company.shares_outstanding).to eq(1000000000)
  end
end
