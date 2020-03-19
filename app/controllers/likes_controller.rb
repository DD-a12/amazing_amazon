class LikesController < ApplicationController
    
    def create
        review = Review.find params[:review_id]
        like = Like.new(user: current_user, review: review)
        if like.save
            flash[:success] = "Like on review"
            redirect_to review.product
        else
            flash[:danger] = like.errors.full_messages.join(", ")
            redirect_to review.product
        end
    end

    def destroy
        like = Like.find params[:id]
        like.destroy
        flash[:success] = "Unlike on Review"
        redirect_to like.review.product
    end

end
