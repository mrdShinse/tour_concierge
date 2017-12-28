# frozen_string_literal: true

class Event < ApplicationRecord # :nodoc:
  belongs_to :player
  belongs_to :venue
end
