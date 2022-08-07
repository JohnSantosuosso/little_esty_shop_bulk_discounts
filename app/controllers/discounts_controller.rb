class DiscountsController < ApplicationController
   before_action :find_merchant_and_discount, only: [:update]

  def index
    @merchant = find_merchant
    @holidays = HolidayFacade.holidays_dates.compact.first(3)
  end

  def new
    @merchant = find_merchant
  end

  def create
    @merchant = find_merchant
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:error] = "Error #{@discount.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @merchant = find_merchant
    @discount = Discount.find(params[:id])
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def show
    @merchant = find_merchant
    @discount = find_discount
  end

  def edit
    @merchant = find_merchant
    @discount = find_discount
  end

  def update
    @discount.update(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      redirect_to edit_merchant_discount_path(@merchant)
      flash[:error] = "Error #{@discount.errors.full_messages.join(", ")}"
    end

  end

  private
  def find_merchant
    Merchant.find(params[:merchant_id])
  end

  def find_discount
    Discount.find(params[:id])
  end

  def find_merchant_and_discount
    @merchant = find_merchant
    @discount = find_discount
  end

  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end

end