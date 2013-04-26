class User < ActiveRecord::Base
  attr_accessible :name
  has_secure_password

  validates :name,
    presence: true,
    uniqueness: true

end
