class Comment < ActiveRecord::Base
  attr_accessible :review_id, :text, :user_id
end
