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
    # @company = Company.where("name like ?", "#{params[:id].downcase.capitalize}%")
    # @transactions = [@company[0], @company[0].transactions]
    @company = Company.find(params[:id])
    @transactions = [@company, @company.transactions]
    render :json => @transactions
  end

end
