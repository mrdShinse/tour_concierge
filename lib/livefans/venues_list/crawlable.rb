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

      def fetch_venues_list_page(url)
        result = HTTPClient.get(url)
        result.body
      end

      def parse_crawling_count(html)
        oga = Oga.parse_html(html)
        venues_count = oga.xpath('html/body/div/div/h3/span').last.text.delete('件').to_i
        venues_count / 16 + 1
      end

      def parse_venues_list(html)
        oga = Oga.parse_html(html)
        html_venues = oga.xpath('html/body/div/div/div')
        html_venues.map do |venue|
          html_venue = venue.xpath('h3/a')
          { name:   html_venue.text,
            import: "#{livefans_root}#{html_venue.attribute('href')[0].value}" }
        end
      end

      def venues_list_path_format
        livefans_root + '/venue/search/area/JPN-%02d/page:%01d'
      end

      def livefans_root
        'http://www.livefans.jp'
      end
    end
  end
end
