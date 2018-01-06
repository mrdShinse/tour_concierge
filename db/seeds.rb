# frozen_string_literal: true

unless User.all.any?
  User.create(email: 'test@example.com', password: 'tourcon123')
end
