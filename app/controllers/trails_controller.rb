class TrailsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index

#    @search = Trail.search do
#      fulltext params[:search]
#      with(:created_at).less_than(Time.zone.now)
#    end
#   @temp = @search.results
    @temp = Trail.all

    if sort_column == "rating"
      if sort_direction == "asc"
        @trails = @temp.sort_by { |t| t.getRating }
      end
      if sort_direction == "desc"
       @trails = @temp.sort_by { |t| t.getRating }.reverse!
     end
   end
    if sort_column == "name"
      if sort_direction == "asc"
        @trails = @temp.sort_by { |t| t.name }
      end
      if sort_direction == "desc"
        @trails = @temp.sort_by { |t| t.name }.reverse!
      end
    end
    if sort_column == "created_at"
      if sort_direction == "asc"
        @trails = @temp.sort_by { |t| t.created_at }
      end
      if sort_direction == "desc"
        @trails = @temp.sort_by { |t| t.created_at }.reverse!
      end
    end

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

  def new
    puts params
    @review = Review.new

   errorMessages = params[:problemReview]
   if errorMessages != nil
    errorMessages.each do |error|
      @review.errors[:base] << error
    end
  end


  end

  def create
    puts params[:trail][:review]
    @name = params[:trail][:location_attributes]
    review = params[:trail][:review]
  	@trail = Trail.new params[:trail].except!(:location_attributes, :review)

    review[:trail_id] = @trail.id
    newReview = Review.create(review)
    newLoc = Location.create(@name)

    @review = newReview

    if newLoc.valid?
      @trail.location = newLoc
    end

    if (!newReview.valid? or !@trail.valid? or !newLoc.valid?)
      errorLst = []
      newReview.errors.full_messages.each do |message|
        message.sub! "Bodytext", "Review text"
        errorLst << message
      end
      @trail.errors.full_messages.each do |message|
        message.sub!"Location", "Trail path"
        errorLst << message
      end
      newLoc.errors.full_messages.each do |message|
        errorLst << message
      end
      redirect_to :controller => "trails", :action => "new", :problemReview => errorLst      

  else 
    @trail = Trail.create params[:trail].except!(:location_attributes, :review)

    @trail.reviews.build(review)
    @trail.location = newLoc
    @trail.save
	  redirect_to action: 'index'

    end
  end

  def show

   id = params[:id]
   @trail = Trail.find(id)

   @review = Review.new
   errorMessages = params[:problemReview]
   if errorMessages != nil
    errorMessages.each do |error|
      @review.errors[:base] << error
    end
  end

  # @review.errors = params[:problemReview]
    @location = Location.find_by_trail_id(id)
   gon.path = @location.path
  end

private

  def sort_column
    Trail.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
