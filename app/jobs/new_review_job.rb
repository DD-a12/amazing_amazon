class NewReviewJob < ApplicationJob
  queue_as :default

  def perform(new_review_mailer)  
    new_review_mailer.new_review
  end

end
