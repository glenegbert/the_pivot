class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :user
  validates :street_address, presence: :true
  validates :city, presence: :true, format: { with: /\D/ }
  validates :state, length: {is: 2}, format: { with: /\A[a-zA-Z]+\z/ }
  validates :zip, presence: :true, numericality: :true

  self.inheritance_column = :category

  def self.categories
      %w(ShippingAddress BillingAddress)
    end

end
