require 'date'

class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @bbq = Bbq.find(params[:bbq_id])
  end

  def create
    @review = Review.new(review_params)
    @bbq = Bbq.find(params[:bbq_id])
    @review.bbq = @bbq
    @review.user = current_user
    if @review.save
      redirect_to bbq_path(@bbq)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end
