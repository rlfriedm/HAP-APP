class Trail < ActiveRecord::Base
	attr_accessible :description, :name, :rating, :created_at
	has_many :reviews, :dependent => :destroy

	searchable do
    	text :name, :boost => 2, :stored => true
    	text :description, :stored => true
#    	text :publish_month
    	text :reviews do
    		reviews.map(&:bodyText)
    	end
        string :name
        integer :rating
    	time :created_at
#    	string :publish_month
  	end

#	def publish_month
#    	created_at.strftime("%B %Y")
#  	end

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

end
