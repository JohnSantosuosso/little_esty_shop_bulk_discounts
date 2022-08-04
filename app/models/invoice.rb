class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def relevant_discounts
    invoice_items #start with invoice_items
    .joins(:discounts) # this is the join table, only made possible by associations created earlier in models
    .where('invoice_items.quantity >= discounts.quantity_threshold') #what criteria do I need to determine whether a discount is applied?
    .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage / 100.00)) as total_discount') 
    #What do I want to select? all of the relevant invoice items as specified by the criteria above
    #BUT what if there are multiple discounts applicable? I want to use the largest one and then apply the appropriate discount percentage
    .group(:id) #how do I group the results?
    .sum(&:total_discount) #how do I get the total for all of the relevant invoice items with discount applied?
  end

  def total_discounted_revenue
    total_revenue - relevant_discounts #in order to get the total discounted revenue, I need to subtract the relevant discounts from the total revenue
  end

end
