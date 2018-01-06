# frozen_string_literal: true

FactoryBot.define do
  factory :venue, class: Venue do
    sequence :name do |n|
      "会場#{n}"
    end
    import { generate :import_id }
  end
end
