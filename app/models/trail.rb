class Trail < ActiveRecord::Base
	attr_accessible :description, :name, :rating, :created_at, :user_id
	has_many :reviews, :dependent => :destroy
    belongs_to :user
    has_one :location, autosave: true
    accepts_nested_attributes_for :location

    include Tire::Model::Search
    include Tire::Model::Callbacks

	def publish_month
    	created_at.strftime("%B %Y")
  	end

    def getRating
        newRating = 0
        numReviews = 0.0
        self.reviews.each do |review| 
            newRating += review.rating
            numReviews += 1
        end
        if numReviews > 0
            rating = ((newRating / numReviews) * 2).round / 2.0
        else
            rating = 0
        end
    end

    def setReview (review)
      @review = review
    end
end
