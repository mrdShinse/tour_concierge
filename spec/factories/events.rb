# frozen_string_literal: true

FactoryBot.define do
  factory :event, class: Event do
    association :player, factory: :player
    association :venue,  factory: :venue
    import { generate :import_id }
  end
end
