# frozen_string_literal: true

json.array! @venues, partial: 'admin_venues/admin_venue', as: :admin_venue
