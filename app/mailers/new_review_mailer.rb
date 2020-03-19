class NewReviewMailer < ApplicationMailer
    def new_review(review)
        @review = review
        @product = @review.product
        @owner = @product.user
        mail(
            to: @owner.email,
            subject: 'You got a new review'
        )
    end
    handle_asynchronously :new_review
end
