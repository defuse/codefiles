class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  attr_accessible :name

  validates :name,
    presence: true,
    uniqueness: true

  def to_param
    self.name
  end
end
