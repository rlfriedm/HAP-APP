class UsersController < ApplicationController
  def index
    if (!signed_in?)
      redirect_to root_path
    end
  	@users = User.all
  end
  def show
   @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def auth
    #render :text => params.inspect
    @username = params[:username]
    @password = params[:password]
  end
  def create
  	@user = User.new(params[:user])
    if @user.save
  	 redirect_to action: 'show', :id => @user.id
     sign_in(@user)
    else
     render 'new'
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
