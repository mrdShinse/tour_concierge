# frozen_string_literal: true

class Player < ApplicationRecord # :nodoc:
  has_many :events
end
