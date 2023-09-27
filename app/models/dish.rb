class Dish < ApplicationRecord
  validates :name, presence: true

  before_create :log

  def log
    pp 'yehey'
  end
end
