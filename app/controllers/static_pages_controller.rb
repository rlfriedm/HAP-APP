class StaticPagesController < ApplicationController
  def forgotten_password_confirmation
    email = params[:static_page][:email]

    @user = User.find_by_email(email)
    if @user
      UserMailer.forgot_password(@user).deliver
    else
      flash.now[:error] = "The email address \"" + email + "\"" + " does not appear to ne assosciated with an account"
      render :action => "forgot"
    end

  end

  def signup
     id = params[:id]
     @user = User.find(id)
  end

  def forgot
  end

  def login
  end

  def home
  	@trails = Trail.all
  	@locations = Location.all

  	@latLngs = []
    @paths = []
    @names = []
    
    @info = []
    @trails.each do |trail|
    	
       
      @names.push(trail.name)

      @info.push({:name => trail.name, 
                  :description => trail.description, 
                  :rating => trail.getRating,
                  :trail_id => trail.id})

      @loc = Location.find_by_trail_id(trail.id)
      @paths.push(@loc.path)

    end 

    # @locations.each do |location|
    #     if location.latitude
    #       latLng = [location.latitude, location.longitude]
    #       @latLngs.push(latLng)
    #     elsif location.startLat
    #       @paths.push(location.path)
    #     end
    # end 
    
    #@json = @json.to_json
    gon.infos = @info
    gon.latLngs = @latLngs
    gon.names = @names
    gon.paths = @paths
  end

  def about
  end

  def contact
  end
end
