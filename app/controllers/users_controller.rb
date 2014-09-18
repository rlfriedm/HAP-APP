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
  def update
    #render :text => params.inspect
    retUser = params[:user]
    curUser = User.find(params[:id])
    curUser.email = retUser[:email]
    curUser.password = retUser[:password]
    curUser.save
    redirect_to action: 'index'
  end
end
