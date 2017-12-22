# frozen_string_literal: true

module Livefans
  class SearchArtistsListJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_artist_list

    def perform(*_args)
      Livefans::Crawler.new.crawl_artists_list
    end
  end
end
