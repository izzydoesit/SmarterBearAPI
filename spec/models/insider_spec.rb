require 'rails_helper'

RSpec.describe Insider, type: :model do
  let(:company) { Company.create!(name: 'Google, Inc.', ticker: 'GOOG', shares_outstanding: 1000000000, cik_number: 1652044) }

  let(:insider) { Insider.create!(name: "Joe Stockholder", relationship: "Officer", company_id: company.id)}
  
  it "has a name" do
    expect(insider.name).to eq("Joe Stockholder")
  end

  it "has a stock holder relationship with a company" do
    expect(insider.relationship).to eq("Officer")
  end

  it "is associated with a company" do
    expect(insider.company).to eq(company)
  end
end
