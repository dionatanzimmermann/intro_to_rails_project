class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:edit, :update, :destroy]

  def create
    @review = @book.reviews.new(review_params)
    @review.user = User.first

    if @review.save
      redirect_to @book, notice: 'Review was successfully created.'
    else
      render 'books/show'
    end
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])
    render 'books/show'
  end

  def update
    if @review.update(review_params)
      redirect_to @book, notice: 'Review was successfully updated.'
    else
      render 'books/show'
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: 'Review was successfully deleted.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end