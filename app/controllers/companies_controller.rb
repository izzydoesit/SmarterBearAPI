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
    @company_info = {insider_count: @company.insiders.count, transactions_total: @company.transactions_total_value}
    @buys = {buys: @company.format_chart_data("A") }
    @sells = {sells: @company.format_chart_data("D") }
    @transactions = [@company, @buys, @sells, @company_info]
    render :json => @transactions
  end

end
