class Photo < ActiveRecord::Base
  attr_accessible :review_id, :image
  belongs_to :review
  has_attached_file :image, :styles => { :small => "150x150>", :large => "320x240>"}
  validates_attachment_presence :image
  do_not_validate_attachment_file_type :image

  validates_attachment_size :image, :less_than => 5.megabytes

end
