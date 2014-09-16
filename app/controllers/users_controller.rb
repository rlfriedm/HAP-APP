class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  def create
  	User.create params[:user]
 	@curUser = :user
  	redirect_to action: 'index'
  end
end
