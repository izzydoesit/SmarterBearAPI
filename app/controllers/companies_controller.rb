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
    @company = Company.find_by(name: params[:id])
    @transactions = [@company, @company.transactions]
    render :json => @transactions
  end

end
