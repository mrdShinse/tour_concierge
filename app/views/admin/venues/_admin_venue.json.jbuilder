# frozen_string_literal: true

json.extract! admin_venue, :id, :created_at, :updated_at
json.url admin_venue_url(admin_venue, format: :json)
