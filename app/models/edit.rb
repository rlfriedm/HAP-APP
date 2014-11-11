class Edit < ActiveRecord::Base
  attr_accessible :review_id, :text, :user_id
  belongs_to :user
  belongs_to :review
end
