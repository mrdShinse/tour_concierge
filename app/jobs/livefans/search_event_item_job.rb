# frozen_string_literal: true

module Livefans
  class SearchEventItemJob < ApplicationJob # :nodoc:
    queue_as :livefans_search_event_item

    def perform(event, *_args)
      Livefans::Crawler.new.crawl_event_item event
    end
  end
end
