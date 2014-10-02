module UsersHelper
	def gravatar_for(user, options = { :size => 100}) #:default => "app/assets/images/rails.png"
		gravatar_image_tag(user.email.downcase, :alt => "no gravatar",
												:class => "gravatar",
												:gravatar => options)
	end
end
