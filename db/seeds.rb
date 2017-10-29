# frozen_string_literal: true

return if User.all.any?

User.create(email: 'test@example.com', password: 'tourcon123')
