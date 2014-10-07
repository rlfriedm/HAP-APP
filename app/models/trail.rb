class Trail < ActiveRecord::Base
	attr_accessible :description, :name, :rating, :created_at
	has_many :reviews

	searchable do
    	text :name, :boost => 5
    	text :description, :boost => 2
    	text :publish_month
    	text :reviews do
    		reviews.map(&:bodyText)
    	end
    	time :created_at
    	string :publish_month
  	end

	def publish_month
    	created_at.strftime("%B %Y")
  	end

end
