class Api::V1::ProductsController < Api::ApplicationController
    before_action :authenticated_user!, except: [:index, :show]
    
    def index
        products = Product.order(created_at: :desc)
        render(
            json: products, 
            each_serializer: ProductCollectionSerializer
        )
    end

    def show
        product = Product.find(params[:id])
        render json: product
    end

    def create
        product = Product.new product_params
        product.user = current_user
        if product.save 
            render(
                json: { id: product.id }
            )
        else
            render(
                json: { errors: product.errors },
                status: 422
            )
        end
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price)
    end

end
