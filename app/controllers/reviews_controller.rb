class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :update, :edit]
  before_action :load_review, only: [:show, :update, :edit]

  def show; end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = t "msg.create_review_success"
    else
      flash[:danger] = t "msg.create_review_fail"
    end
    render :new
  end

  def edit; end

  def update
    @review.assign_attributes review_params
    if @review.save(context: :update_review)
      flash[:success] = t "msg.update_success"
    else
      flash[:danger] = t "msg.update_fail"
    end
    render :edit
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    redirect_to root_path
  end

  def review_params
    params.require(:review).permit :title, :description, :content,
      :category, :image
  end
end
