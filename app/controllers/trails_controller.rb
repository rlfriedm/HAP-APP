class TrailsController < ApplicationController
  def index
  	@trails = Trail.all 
  end
  def create
  	Trail.create params[:trail]
	redirect_to action: 'index'
  end
  def trail
  	id = params[:id]
  	@trail = Trail.find(id)
  end

end
