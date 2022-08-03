class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show]

  def index
    
  end

end