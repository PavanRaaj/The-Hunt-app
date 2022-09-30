class PageController < ApplicationController

  def index
  end

  def new_review
    @review = Review.new
    render 'page/reviews'
  end

  def review_details
    reviews = Review.new(review_params)
    reviews.user_id = current_user.id
    if reviews.save
      redirect_to review_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:review)
  end
end
