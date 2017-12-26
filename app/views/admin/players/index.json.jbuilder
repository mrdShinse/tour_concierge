# frozen_string_literal: true

json.array! @players, partial: 'admin_players/admin_player', as: :admin_player
