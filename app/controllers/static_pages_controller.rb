class StaticPagesController < ApplicationController
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

  def signup
  end

  def contact
  end
end
