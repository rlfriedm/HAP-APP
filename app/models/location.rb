class Location < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :name, :startLat, :startLng, :endLat, :endLng, :path
  #acts_as_gmappable
  geocoded_by :address
  after_validation :geocode 
  serialize :path, JSON
  before_save :setPath
  belongs_to :trail
  validates :path,   :presence => true

  def setPath
  	if path
  		puts "blah"
  		puts path
  # 		start = []
  # 		start.push(startLat)
  #  		start.push(startLng)

  #  		ends = []
  # 		ends.push(endLat)
  #  		ends.push(endLng)
  # 		paths = []

  # 		paths.push(start)
  # 		paths.push(ends)

  # 		self.path = paths
  	else 
  		puts "hello"
  	end

  end
  #def gmaps4rails_address
  #	address
  #end
end
