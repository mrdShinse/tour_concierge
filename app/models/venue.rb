# frozen_string_literal: true

class Venue < ApplicationRecord # :nodoc:
  has_many :events
  reverse_geocoded_by :latitude, :longitude
  scope :nearby, ->(lat, long, dist = 20) { near([lat, long], dist, unites: :km) }

  def latlong
    "#{latitude}-#{longitude}"
  end
end
