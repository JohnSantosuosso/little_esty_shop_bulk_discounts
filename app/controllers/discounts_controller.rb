class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create]

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

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end

end