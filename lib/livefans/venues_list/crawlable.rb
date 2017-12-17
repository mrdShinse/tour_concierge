# frozen_string_literal: true

module Livefans
  module VenuesList
    module Crawlable # :nodoc:
      def crawl_venues_list
        Prefecture.ids.map { |id| crawl_venues_list_by_pref id }.flatten
      end

      def crawl_venues_list_by_pref(code)
        count = parse_crawling_count(
          fetch_venues_list_page(venues_list_path(code, 1))
        )
        data = count.times.map do |c|
          parse_venues_list(
            fetch_venues_list_page(venues_list_path(code, c + 1))
          )
        end
        data.flatten
      end

      def venues_list_path(pref_code, page)
        format(venues_list_path_format, pref_code, page)
      end

      def fetch_venues_list_page(_url)
        ''
      end

      def parse_crawling_count(html)
        7
      end

      def parse_venues_list(_html = '')
        [{}, {}]
      end

      def venues_list_path_format
        'http://www.livefans.jp/venue/search/area/JPN-%02d/page:%01d'
      end
    end
  end
end
