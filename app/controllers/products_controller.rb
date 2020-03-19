class ProductsController < ApplicationController
    before_action :authenticate_user! ,except: [:index, :show]
    before_action :find_product, only: [:edit,:update, :show, :destroy]
    before_action :authenticate!, only: [:edit, :update, :destroy]
    def new
        @product=Product.new
    end
    def create
        @product = Product.new product_params
        @product.user = current_user
        if @product.save
            ProductMailer.new_product(@product).deliver_now
            flash[:notice] = 'product Created Successfully'
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end
    def edit
        
    end
    def update
        
        if @product.update product_params
            flash[:notice] = 'product updated Successfully'
            redirect_to product_path(@product.id)
        else
            render :edit
        end
    end

    def index 
        if params[:tag]
            @tag = Tag.find_or_initialize_by(name: params[:tag])
            @products = @tag.products.order(created_at: :desc) 
        else
            @products = Product.all
        end
    end

    def show
        @voting = Vote.new
        @review = Review.new
        @reviews = @product.reviews.order(created_at: :desc)
    end

    def destroy
        
        @product.destroy
        redirect_to products_path
    end

    private
    
    def find_product
        @product=Product.find params[:id]
    end

    def product_params
        params.require(:product).permit(:title, :description, :price, :tag_names)
    end

    def authenticate!
        unless can? :crud, @product
            redirect_to root_path, alert: "Not Authorized"
        end
    end
end
