# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module VenuesList
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_venues_list
        venues_list = Prefecture.ids.map { |id| crawl_venues_list_by_pref id }.flatten
        venues_list.compact.each do |venue|
          next if venue.empty?
          Venue.find_or_initialize_by(import: venue[:import]) { |v| v.update(venue) }
        end
      end

      def crawl_venues_list_by_pref(code)
        count = parse_venues_list_crawling_count(
          fetch_page(venues_list_path(code, 1))
        )
        data = count.times.map do |c|
          parse_venues_list(
            fetch_page(venues_list_path(code, c + 1))
          )
        end
        data.flatten
      end

      def parse_venues_list_crawling_count(html)
        oga = Oga.parse_html(html)
        venues_count_text = oga.xpath('html/body/div/div/h3/span').last.try(:text)
        return 1 unless venues_count_text
        venues_count = venues_count_text.delete('件').try(:to_i)
        return 1 unless venues_count
        venues_count / 16 + 1
      end

      def parse_venues_list(html)
        oga = Oga.parse_html(html)
        html_venues = oga.xpath('html/body/div/div/div')
        html_venues.map do |venue|
          a_tag = venue.xpath('h3/a')
          return nil if a_tag.attribute('href').nil? || a_tag.attribute('href')[0].try(:value).nil?
          { name:   a_tag.text,
            import: "#{livefans_root_url}#{a_tag.attribute('href')[0].value}" }
        end
      end
    end
  end
end
