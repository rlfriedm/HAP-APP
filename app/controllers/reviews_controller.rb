class ReviewsController < ApplicationController
	def create
		id = params[:review][:trail_id]
		@trail = Trail.find(id)
		@review = @trail.reviews.build(params[:review])

		if @review.save
			redirect_to :back
		end
	end

	def deleteReview
  		reviews = Trail.find(params[:trail_id]).reviews
  		review = reviews.find(params[:review_id])
  		review.destroy
  		redirect_to :back
  	end
end
