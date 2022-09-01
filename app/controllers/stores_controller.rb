class StoresController < ApplicationController
 before_action :set_params, only: %i[destroy edit update show]
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update, :destroy, :show]


  def index
    @stores = Store.where(user_id: current_user)

  end

  def show
    @product = Product.new
  end

  def new
    @store = Store.new
  end

  def create
    @store=Store.new(store_params)
    if @store.save
      redirect_to store_path(@store)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @store.destroy
    redirect_to stores_path, notice: "Your Store is Deleted🥺!!"
  end



  def edit

  end

  def update
    if @store.update(store_params)
      redirect_to store_path(@store), notice: "Your Store has been edited successfully!!"
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def correct_user
    @store = current_user.stores.find_by(id: params[:id])
    redirect_to stores_path, notice: "Not Authorized ❌" if @store.nil?
  end

  private

  def set_params
    @store = Store.find(params[:id])
  end

   def store_params
     params.require(:store).permit(:name, :address, :opening_hour, :closing_hour, :user_id)
  end
end
