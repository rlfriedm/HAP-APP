class Location < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :name
  #acts_as_gmappable
  geocoded_by :address
  after_validation :geocode 
  #def gmaps4rails_address
  #	address
  #end
end
