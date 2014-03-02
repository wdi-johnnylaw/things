class Thing < ActiveRecord::Base
  has_many :opinions

  validates :name, uniqueness: true
end
