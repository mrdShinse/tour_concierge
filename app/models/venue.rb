# frozen_string_literal: true

class Venue < ApplicationRecord # :nodoc:
  def latlong
    "#{latitude}-#{longitude}"
  end
end
