class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing

  validates :user_id, uniqueness: { scope: [:thing_id] }
end
