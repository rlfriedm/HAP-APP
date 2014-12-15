class ReviewsController < ApplicationController
	def create
		id = params[:review][:trail_id]
		@trail = Trail.find(id)
		puts "heerererereerere"
		if not params[:review][:photos].nil?
			(params[:review][:photos]).each_with_index do |photo, i|
				params[:review][:photos][i] = Photo.new(:image => photo)
			end
		end

		photos = params[:review][:photos]

		thereview = Review.new(params[:review])
		if (!thereview.valid?)
			#redirect_to @trail.show(:params => params[:trail_id]), :locals => {:@review => thereview}
			errorLst = []
			thereview.errors.full_messages.each do |message|
				errorLst << message
			end
			redirect_to :controller => "trails", :action => "show", :id => id, :problemReview => errorLst
	#		render "trails/show" , :locals => {:@review => thereview}
			
		end
		review = @trail.reviews.build(params[:review])
              
	#	render :text => current_user.reviews
		current_user.reviews.build(params[:review])
            #    @review.save!
        #review.save
		if review.save
			redirect_to :controller => "trails", :action => "show", :id => id
        end

	end


	def deleteReview
  		reviews = Trail.find(params[:trail_id]).reviews
  		review = reviews.find(params[:review_id])
  		review.destroy
  		redirect_to :back
  	end
end
