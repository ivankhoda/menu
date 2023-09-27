# frozen_string_literal: true

FactoryBot.define do
  factory :dish, class: Dish do
    sequence(:id) { |n| "#{n}" }
    sequence(:name) { |n| "Dish #{n}" }
  end
end
