# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module EventsList
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def parse_events_list_crawling_count(_); end

      def parse_events_list(_); end

      def events_list_path(_, _); end
    end
  end
end
