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
  end

  def create
    puts params[:trail][:location_attributes]
    @name = params[:trail][:location_attributes]
  	@trail = Trail.create params[:trail].except!(:location_attributes)
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    
    if @trail.save
      @trail.build_location
    end
    @trail.location = Location.new(@name)

	  redirect_to action: 'index'
  end

  def show
  #  render :text => params[:problemReview]

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
