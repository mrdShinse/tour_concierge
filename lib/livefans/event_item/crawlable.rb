# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module EventItem
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def parse_event_item(_html)
        {}
      end
    end
  end
end
