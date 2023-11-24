# frozen_string_literal = true

class TelegramUser < ApplicationRecord
  has_many :dishes
end
