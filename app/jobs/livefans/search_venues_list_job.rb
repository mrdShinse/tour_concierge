# frozen_string_literal: true

module Livefans
  class SearchVenuesListJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_venue_list

    def perform(*_args)
      Livefans::Crawler.new.crawl_venues_list
    end
  end
end
