class FormsController < ApplicationController
  def index
    @forms = Form.all
    render :json => @forms
  end
end
