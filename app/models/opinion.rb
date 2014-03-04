class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing

  default_scope { order(updated_at: :desc) }

  validates :user_id, uniqueness: { scope: [:thing_id] }
  validates :comment, presence: true
  validates :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true,
    message: 'must be an integer between 1 and 5'
  }
end
