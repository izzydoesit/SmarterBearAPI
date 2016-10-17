class CompaniesController < ApplicationController
  def index
    if params[:search]
      @results = Company.search(params[:search])
      render :json => @results
    else
      @companies = Company.all
      render :json => @companies
    end
  end
  
  def show
    @company = Company.find(params[:id])
    @transactions = [@company, @company.transactions_this_month]
    render :json => @transactions
  end

end
