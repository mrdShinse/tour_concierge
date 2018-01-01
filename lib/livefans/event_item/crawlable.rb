# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module EventItem
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def parse_event_item(html)
        oga = Oga.parse_html(html)
        { start_at: parse_start_at(oga) }
      rescue
        {}
      end

      def parse_start_at(oga)
        text = oga.xpath('html/body/div/div/div/div/div/div/p')[0].text
        m = text.match(%r{(\d{4})/(\d{2})/(\d{2}).*(\d{2}):(\d{2}).*})
        Time.zone.local(m[1], m[2], m[3], m[4], m[5])
      end
    end
  end
end
