class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :addresses

  validates :full_name, presence: true
  validates_format_of :email_address, :with => /\A.+@.+\..+\z/i
  validates :email_address, uniqueness: true

  Roles = [ :admin , :user, :seller ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

end
