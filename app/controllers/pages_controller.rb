class PagesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  def home
   
  end

  def dashboard
  end
end
