# frozen_string_literal: true

FactoryBot.define do
  factory :player, class: Player do
    name   { generate :fake_name }
    import { generate :import_id }
  end
end
