class HomeController < ApplicationController
  before_filter :authenticate_user!, :only =>[:new]

  def index
  end
  
  def new 
    @user = current_user
  end

end
