class EditsController < ApplicationController
  def create
    @review = Review.find(params[:edit][:review_id])
    @edit = @review.edits.build(params[:edit])

    if @edit.save!
      redirect_to :back
    end
  end


end