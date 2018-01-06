# frozen_string_literal: true

FactoryBot.define do
  sequence :import_id do
    SecureRandom.uuid
  end

  sequence :fake_name do
    Faker::Name.name
  end
end
