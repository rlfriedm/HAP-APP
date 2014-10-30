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
#    @trails = Trail.order(sort_column + " " + sort_direction).paginate(:per_page => 2, :page => params[:page])

#    @trails = @search.results.order_by(sort_column + " " + sort_direction).paginate(:per_page => 2, :page => params[:page])

#    @trails = @temp.order(sort_column + " " + sort_direction).paginate(:per_page => 2, :page => params[:page])

  end

  def create
  	Trail.create params[:trail]
	  redirect_to action: 'index'
  end

  def show
    id = params[:id]
    @trail = Trail.find(id)
  end

private
  
  def sort_column
    Trail.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
