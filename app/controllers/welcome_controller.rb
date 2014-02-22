class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if signed_in?
        redirect_to welcome_dashboard_path
    end
    
  end
  

  
end


