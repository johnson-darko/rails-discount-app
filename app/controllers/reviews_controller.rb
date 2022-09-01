class ReviewsController < ApplicationController
  before_action :set_store, only: [:new, :create]
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.store_id = @store.id
    if @review.save
      redirect_to store_reviews_path(@store)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
