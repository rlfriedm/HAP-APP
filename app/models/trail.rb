class Trail < ActiveRecord::Base
  attr_accessible :description, :name, :rating
  has_many :reviews
end
