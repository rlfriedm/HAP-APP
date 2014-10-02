class Trail < ActiveRecord::Base
	attr_accessible :description, :name, :rating
	has_many :reviews

	searchable do
    	text :name, :boost => 5
    	text :description
    	float :rating
  	end

end
