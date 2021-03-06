class Store < ActiveRecord::Base
  scope :authorized, -> { where(authorized: true)}
  scope :online, -> { where(online: true)}

  before_validation :remove_slug_spaces

  validates :name, :slug, :user_id, uniqueness: true
  validates :description, :slug, :name, presence: true
  has_many :items
  has_many :orders
  belongs_to :user
  has_many :store_managers
  has_many :users, through: :store_managers

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def remove_slug_spaces
    self.slug.gsub!(/[" "]/, '_')
  end

  def completed_orders
    orders.where(:status => "completed")
  end

  def paid_orders
    orders.where(:status => "paid")
  end

  def canceled_orders
    orders.where(:status => "canceled")
  end

  def recent_orders
    orders.where(:status => "ordered")
  end

  def self.waitng_approval
    where(:authorized == false)
  end
end
