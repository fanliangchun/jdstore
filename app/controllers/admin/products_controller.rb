class Admin::ProductsController < ApplicationController
	before_action :find_products, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :admin_required
	layout "admin"
	def index
		@products = Product.all
	end

	def show
	end

	def new
		@product = Product.new
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def create
	@product = Product.new(product_params) 
   @product.category_id = params[:category_id] 
   respond_to do |format| 
   if @product.save 
      format.html { redirect_to @product, notice: 'Product was successfully created.' } 
      format.json { render :show, status: :created, location: @product } 
   else 
       format.html { render :new } 
       format.json { render json: @product.errors, status: :unprocessable_entity } 
   end 
  end 
	end

	def edit
		@categories = Category.all.map { |c| [c.name, c.id] }
	end

	def update
		@product.category_id = params[:category_id]
		if @product.update(product_params)
			redirect_to admin_products_path, notice: "Update success"
		else
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to admin_products_path, alert: "Product Deleted"
	end

	private

	def find_products
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:title, :description, :quantity, :price, :image, :category_id)
	end
end
