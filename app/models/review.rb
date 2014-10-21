class Review < ActiveRecord::Base
  attr_accessible :bodyText, :rating, :title, :trail_id, :photos_attributes, :photos
  belongs_to :trail
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
end
