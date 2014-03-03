class Thing < ActiveRecord::Base
  has_many :opinions

  validates :name, uniqueness: true

  def average_rating
    opinions.average(:rating)
  end
end
