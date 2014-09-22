class Review < ActiveRecord::Base
  attr_accessible :bodyText, :rating, :title, :trail_id
  belongs_to :trail
end
