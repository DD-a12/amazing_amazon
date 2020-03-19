class ProductMailer < ApplicationMailer
    def new_product(product)
        @product = product
        @owner = @product.user
        mail(
            to: @owner.email,
            subject: 'You made a new product on our website'
        )
    end
    handle_asynchronously :new_product
end
