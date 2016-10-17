class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @companies.each { |company| company[:confidence_rating] = company.rate_confidence }
    render :json => @companies
  end

  def show
    @company = Company.find(params[:id])
    @transactions = [@company, @company.transactions_this_month]
    render :json => @transactions
  end
end
