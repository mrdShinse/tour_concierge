# frozen_string_literal: ture

json.array! @events, partial: 'events/event', as: :event
