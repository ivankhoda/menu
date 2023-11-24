class Dish < ApplicationRecord
  validates :name, presence: true

  belongs_to :telegram_user

  scope :user_dish, ->(user) { where(telegram_user: user) }
end
