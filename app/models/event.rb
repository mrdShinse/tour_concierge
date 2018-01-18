# frozen_string_literal: true

class Event < ApplicationRecord # :nodoc:
  belongs_to :player
  belongs_to :venue, optional: true

  scope :future,      -> { where('start_at > ?', Time.current) }
  scope :start_until, ->(num) { where('start_at < ?', num.days.from_now) }
  scope :nearby,      ->(lat, long, dist = 20) { where(venue_id: Venue.nearby(lat, long, dist).map(&:id)) }
end
