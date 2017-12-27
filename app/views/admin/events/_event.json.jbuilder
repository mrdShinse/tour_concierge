# frozen_string_literal: true

json.extract! event, :id, :player_id, :venue_id, :name, :start_at, :import, :created_at, :updated_at
json.url event_url(event, format: :json)
