class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :destroy, :edit, :update]

  def index
  end

  def new
  end

  def create
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:error] = "Error #{@discount.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to edit_merchant_discount_path(@merchant)
      flash[:error] = "Error #{@discount.errors.full_messages.join(", ")}"
    end

  end

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end

end