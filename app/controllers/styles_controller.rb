class StylesController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def index
    render :layout => "styles"
  end
end