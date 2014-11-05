class Order < ActiveRecord::Base
  validates :status, inclusion: {in: %w(paid completed canceled ordered)}
  validates :store_id, presence: true
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user
  belongs_to :address
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :store

  scope :paid,      -> { where(status: "paid") }
  scope :completed, -> { where(status: "completed") }
  scope :canceled,  -> { where(status: 'canceled') }
  scope :ordered,   -> { where(status: 'ordered')}

  def self.valid_statuses
    ['paid', 'completed', 'canceled', 'ordered']
  end

  def subtotal
    line_totals = order_items.map {|order_item| order_item.line_total}
    line_totals.reduce(:+)
  end

  def tax
    subtotal * ".05".to_f
  end

  def total
    subtotal + tax
  end
end
