class ReviewsController < ApplicationController
    before_action :authenticate_user!
    def create
        @product = Product.find params[:product_id]
        @review = Review.new review_params
        @review.user = current_user
        @review.product = @product
        if @review.save
            NewReviewMailer.new_review(@review).deliver_now
            redirect_to product_path(@product)
        else
            @review = @product.reviews.order(rating: :desc)
            render 'products/show'
        end
    end
    def edit
    end
    def update
        if @review.update review_params
            flash[:notice] = 'review updated Successfully'
            redirect_to product_path(@review.product)
        else
            render :edit
        end
    end
    
    def hidden
        @review = Review.find params[:id]
        if @review[:hidden] == false && @review.product.user == current_user
            @review[:hidden] = true
        else @review[:hidden] == true && @review.product.user == current_user
            @review[:hidden] = false
        end
        if @review.update params.permit(:body, :rating, :hidden)
            redirect_to product_path(@review.product)
        end
    end

    def destroy
        @review = Review.find params[:id]
        if can? :crud, @review 
            @review.destroy
            redirect_to product_path(@review.product) , notice: "Review destroyed"
        else
            redirect_to root_path, notice: "Not Authorized"
        end
    end
    
    def liked
        reviews = current_user.liked_reviews
        @products = reviews.product
        render 'products#index'
    end

    private
    
    def review_params
        params.require(:review).permit(:body, :rating, :hidden, :throw_vote)
    end
   
end
