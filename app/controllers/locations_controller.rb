class LocationsController < ApplicationController
  #before_action :set_location, only: [:show, :edit, :update, :destroy]
   #GET /locations
   #GET /locations.json
  def index
    @locations = Location.all
    # @randString = "randString"
    @json = Gmaps4rails.build_markers(@locations) do |location, marker|
       marker.lat location.latitude
       marker.lng location.longitude
       #marker.json({address: location.address})
       marker.picture Hash["url" => "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
         "width" =>  36,
         "height"=> 36 ]
     end
    @latLngs = []
    @paths = []
    @locations.each do |location|
        if location.latitude
          latLng = [location.latitude, location.longitude]
          @latLngs.push(latLng)
        elsif location.startLat
          @paths.push(location.path)
        end
    end 
    
    #@json = @json.to_json
    gon.latLngs = @latLngs
    gon.paths = @paths
    #render :text => gon.latLngs
    # #@json = Location.all.to_gmaps4rails
    respond_to do |format|
     #format.json { render :json => @json }
      format.html # index.html.erb
     
    end
#    render :text => @json 
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
    @locations = Location.all
    @latLngs = []
    @paths = []
    @locations.each do |location|
        if location.latitude
          latLng = [location.latitude, location.longitude]
          @latLngs.push(latLng)
        elsif location.path
          @paths.push(location.path)
        end
    end 
    
    #@json = @json.to_json
    gon.latLngs = @latLngs
    gon.paths = @paths

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
