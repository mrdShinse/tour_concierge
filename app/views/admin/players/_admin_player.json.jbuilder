# frozen_string_literal: true

json.extract! admin_player, :id, :name, :import, :created_at, :updated_at
json.url admin_player_url(admin_player, format: :json)
