class ReviewsController < ApplicationController
	def create
		id = params[:review][:trail_id]
		@trail = Trail.find(id)
		
		if not params[:review][:photos].nil?
			(params[:review][:photos]).each_with_index do |photo, i|
				params[:review][:photos][i] = Photo.new(:image => photo)
			end
		end

		photos = params[:review][:photos]

		@review = @trail.reviews.build(params[:review])
	
		if @review.save!
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
