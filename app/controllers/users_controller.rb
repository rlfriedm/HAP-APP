class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  def show
    if not User.exists?(:id => params[:id])
      redirect_to action: 'index'
    end
    @user = User.find(params[:id])
  end
  def auth
    #render :text => params.inspect
    @username = params[:username]
    @password = params[:password]
  end
  def create
  	user = User.new(params[:user])
    if user.save
  	 redirect_to action: 'index'
    else
     render :text => user.errors.full_messages
    end
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
