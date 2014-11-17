class TrailsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index

    @search = Trail.search do
      fulltext params[:search]
      order_by(sort_column, sort_direction)
#      with(:created_at).less_than(Time.zone.now)
#      facet(:publish_month)
#      if params[:month].present?
#        with(:publish_month, params[:month])
#      end
      paginate(:per_page => 5, :page => params[:page])
    end
    @trails = @search.results

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
    id = params[:id]
    @trail = Trail.find(id)

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
