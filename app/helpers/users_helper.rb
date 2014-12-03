module UsersHelper
	def gravatar_for(user, options = { :size => 100}, gClass) #:default => "app/assets/images/rails.png"
		gravatar_image_tag(user.email.downcase, :alt => "no gravatar",
												:class => gClass,
												:gravatar => options)
	end

	def getRevComments(user, revId)
		comments = user.comments
		result=[]
		for comment in comments 
			if (comment.review_id == revId)
				result.append(comment)
			end	
		end
		return comments #fix!
	end
end
