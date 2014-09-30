class PhotoController < ApplicationController
	def new
		@photo = Photo.new
	end
end
