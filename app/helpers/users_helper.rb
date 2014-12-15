module UsersHelper
	def gravatar_for(user, options = { :size => 100}, gClass) #:default => "app/assets/images/rails.png"
		gravatar_image_tag(user.email.downcase, :alt => "no gravatar",
												:class => gClass,
												:gravatar => options)
	end

	def getRevComments(user, revId)
		comments = user.comments
		result = Array.new
		for comment in comments 
			if (comment.review_id == revId.to_i)
				result.push(comment.id)
			end	
		end
		return result #fix!
	end

	def getRevCommentsB(user, revId)
		comments = user.comments
		result = Array.new
		for comment in comments 
			if (comment.review_id == revId.to_i)
				result.push(comment)
			end	
		end
		return result #fix!
	end

	def getTrail(revId)
		rev = Review.find(revId)
		trail = Trail.find(rev.trail_id)
		return trail
	end

	def contributedReviews(user)
		reviews = user.reviews
		allRevs = reviews.all
		result = Array.new
		for rev in allRevs
			for cid in getRevComments(user, rev.id)
				if (Comment.find(cid).user_id == user.id and rev.user_id != user.id	)
					result.push(rev.id)
					break
				end	
			end
		end

		for thing in reviews
			result.push(thing.id)
		end
		return result
	end	
end
