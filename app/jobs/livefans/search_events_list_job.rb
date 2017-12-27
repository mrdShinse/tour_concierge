# frozen_string_literal: true

module Livefans
  class SearchEventsListJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_events_list

    def perform(artist, *_args)
      Livefans::Crawler.new.crawl_events_list_by_artist(artist)
    end
  end
end
