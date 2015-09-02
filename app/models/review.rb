class Review < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :rating, inclusion: (1..5)
end
