class TrailsController < ApplicationController
  def index
  	@trails = Trail.all 
  end
  def create
  	Trail.create params[:trail]
	redirect_to action: 'index'
  end
end
