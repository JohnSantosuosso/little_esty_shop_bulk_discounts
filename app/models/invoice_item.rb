class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :discounts, through: :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def has_discount?
    if self.get_discount.nil?
      false
    else
      true
    end
  end

  def get_discount
   discounts
    .where("discounts.quantity_threshold <= ?", quantity)
    .order("percentage desc")
    .first
  end

end
