class TrailsController < ApplicationController
  def index

    @search = Trail.search do
      fulltext params[:search]
      with(:created_at).less_than(Time.zone.now)
      facet(:publish_month)
      if params[:month].present?
        with(:publish_month, params[:month])
      end
    end
    @trails = @search.results #.sort_by{|e| e[:created_at]}.reverse


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
