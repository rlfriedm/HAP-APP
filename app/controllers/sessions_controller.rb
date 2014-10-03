class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], 
  							params[:session][:password])
  	if user.nil?
  		flash.now[:notice] = "Invalid email/password"
  		render 'new'
  	else
  		redirect to controller: "Users", action: "index"
  	end
  end		

  def destroy
  end
end
