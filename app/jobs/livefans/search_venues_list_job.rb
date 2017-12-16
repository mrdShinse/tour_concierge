# frozen_string_literal: true

module Livefans
  class SearchVenuesListJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_venue_list

    def perform(*args); end
  end
end
