class ReviewsController < ApplicationController
	def new
		@trail = Trail.find(params[:trail_id])
		@review = Trail.reviews.build(params[:trail_id])
	end

	def create
		id = params[:review][:trail_id]
		@trail = Trail.find(id)
		@review = @trail.reviews.build(params[:review])

		if @review.save
			redirect_to :back
		end
	end
end
