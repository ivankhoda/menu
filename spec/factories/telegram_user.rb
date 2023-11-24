# frozen_string_literal: true

FactoryBot.define do
  factory :telegram_user, class: TelegramUser do
    sequence(:id) { |n| "#{n}" }
    sequence(:telegram_id) { SecureRandom.uuid }
  end
end