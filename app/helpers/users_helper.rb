module UsersHelper
	def gravatar_for(user, options = { :size => 100}, gClass) #:default => "app/assets/images/rails.png"
		gravatar_image_tag(user.email.downcase, :alt => "no gravatar",
												:class => gClass,
												:gravatar => options)
	end
end
