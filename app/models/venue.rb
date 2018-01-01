# frozen_string_literal: true

class Venue < ApplicationRecord # :nodoc:
  has_many :events

  def latlong
    "#{latitude}-#{longitude}"
  end
end
