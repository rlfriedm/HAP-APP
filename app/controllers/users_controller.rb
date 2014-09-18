class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  def create
  	User.create params[:user]
 	  @curUser = :user
  	redirect_to action: 'index'
  end
  def deleteuser
  	curUser = User.find(params[:id]).destroy
  	@curName = curUser.username
  	curUser.delete
  end
  def edit
  	@curUser = User.find(params[:id])
  end
end
