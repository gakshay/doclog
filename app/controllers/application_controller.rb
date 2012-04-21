class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  private 

  def after_sign_in_path_for(user)
    transactions_path
  end
end
