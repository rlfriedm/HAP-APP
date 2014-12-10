class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
  end
  
  def shower
    @user = User.find(params[:id])
    @revId = params[:revId]
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
  def edit
  	@user = User.find(params[:id])
  end
  def update
    
    retUser = params[:user]
    @user = User.find(params[:id])
    @user.email = retUser[:email]
    @user.password = retUser[:password]
    @user.username = retUser[:username]
    if @user.save
      redirect_to action: 'show'
    else
      render 'edit'
    end 
  end
end
