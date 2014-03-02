class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing

  validates :user_id, uniqueness: { scope: [:thing_id] }
  validates :comment, length: { minimum: 15, message: 'must be at least 15 characters' }
  validates :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true,
    message: 'must be an integer between 1 and 5'
  }
end
