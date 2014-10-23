class CommentsController < ApplicationController
  def create
    @review = Review.find(params[:comment][:review_id])
    @comment = @review.comments.build(params[:comment])

    if @comment.save!
      redirect_to :back
    end
  end


end