class Review < ActiveRecord::Base
  attr_accessible :bodyText, :rating, :title, :trail_id, :photo
  belongs_to :trail
  has_one :photo

  accepts_nested_attributes_for :photo
end
