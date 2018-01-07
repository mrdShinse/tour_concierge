# frozen_string_literal: true

class EventSerializer < ApplicationSerializer # :nodoc:
  attributes %w[id title start_at image url]

  belongs_to :player
  belongs_to :venue, key: :address

  def title
    object.name
  end

  def image
    object.try(:image)
  end

  def url
    object.import
  end

  def start_at
    object.start_at.try(:to_i)
  end

  class PlayerSerializer < ApplicationSerializer # :nodoc:
    attributes %w[id name]
  end

  class VenueSerializer < ApplicationSerializer # :nodoc:
    attributes %w[latitude longitude]
  end
end
