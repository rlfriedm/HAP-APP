class UsersController < ApplicationController
   skip_before_filter :require_login, only: [:new, :create]
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
    tmp = SecureRandom.urlsafe_base64
    other = tmp[0..10]
    @user.password = other
    if @user.save
     UserMailer.forgot_password(@user).deliver
  	 redirect_to controller: 'static_pages', action: 'signup', :id => @user.id
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
    @user.password_confirmation = retUser[:password_confirmation]
    @user.username = retUser[:username]
    if @user.save
      redirect_to action: 'show'
    else
      render 'edit'
    end 
  end
end
