class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include AbstractController::Callbacks
  before_filter :require_login
 
  private
 
  def require_login
    unless signed_in?
      redirect_to root_path
    end
  end
end
