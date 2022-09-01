class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_store, only: [:new, :create]
  def index
    @products = Product.all.order("created_at desc")
  end

  def show
  end

  def edit
  end

  def new
    @product = Product.new
    #@product = current_user.products.build
  end

  def create
    #@product = Product.new(product_params)
    @product=  @store.products.build(product_params)
    @product.store = @store
    if @product.save
      redirect_to store_path(@store)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to store_path(@product.store), status: :see_other
  end

  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    redirect_to products_path, notice: "Not Authorized To Edit❌" if @product.nil?
  end

  private

  def product_params
    params.require(:product).permit(:name, :store_id, :wish_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_store
    @store = Store.find(params[:store_id])
  end
end



