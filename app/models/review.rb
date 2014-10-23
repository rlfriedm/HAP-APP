class Review < ActiveRecord::Base
  attr_accessible :bodyText, :rating, :title, :trail_id, :photos_attributes, :photos, :user_id
  belongs_to :trail
  belongs_to :user
  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :photos
end
