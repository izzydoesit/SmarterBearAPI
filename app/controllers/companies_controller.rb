class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    render :json => @companies
  end

  def show
  end
end
