# frozen_string_literal: true

module Livefans
  class SearchVenueItemJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_venue_item

    def perform(*_args)
      Livefans::Crawler.new.crawl_venue_item_all
    end
  end
end
