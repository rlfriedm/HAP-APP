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

		thereview = Review.new(params[:review])
		if (!thereview.valid?)
			render "trails/show" , :locals => {:@review => thereview}
		end
		@review = @trail.reviews.build(params[:review])
                @trail.setReview @review
              
	#	render :text => current_user.reviews
		current_user.reviews.build(params[:review])
            #    @review.save!
		if @review.save
			redirect_to :back
        end
	#	end

	end


	def deleteReview
  		reviews = Trail.find(params[:trail_id]).reviews
  		review = reviews.find(params[:review_id])
  		review.destroy
  		redirect_to :back
  	end
end
