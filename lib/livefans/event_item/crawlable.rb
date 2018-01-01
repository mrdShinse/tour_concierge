# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module EventItem
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_event_item(event)
        html = fetch_page(event.import)
        data = parse_event_item html
        event.update!(data)
      rescue ActiveRecord::ActiveRecordError => e
        puts e.message
        e.backtrace.each { |m| puts m }
      end

      def parse_event_item(html)
        oga = Oga.parse_html(html)
        { start_at: parse_event_item_start_at(oga.xpath('html/body/div/div/div/div/div/div/p')[0].text),
          venue_id: parse_event_item_venue_id(oga) }
      rescue
        {}
      end

      def parse_event_item_start_at(text)
        m = text.match(%r{(\d{4})/(\d{2})/(\d{2})(.*(\d{2}):(\d{2}).*)?})
        Time.zone.local(m[1], m[2], m[3], m.try(:[], 5), m.try(:[], 6))
      end

      def parse_event_item_venue_id(oga)
        address_tag = oga.xpath('html/body/div/div/div/div/div/div/address/a')
        return nil if address_tag.blank?
        v_import = address_tag.attribute('href')[0].value
        ::Venue.find_by(import: "#{livefans_root_url}#{v_import}").try(:id)
      end
    end
  end
end
