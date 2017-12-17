# frozen_string_literal: true

module Livefans
  module VenuesList
    module Crawlable # :nodoc:
      def crawl_venues_list
        venues_list = Prefecture.ids.map { |id| crawl_venues_list_by_pref id }.flatten
        venues_list.each { |venue| Venue.find_or_initialize_by(import: venue[:import]) { |v| v.update(venue) } }
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
        if @last_fetched.present? && (Time.current.to_i - @last_fetched) < 2
          sleep 1 while (Time.current.to_i - @last_fetched) < 2
        end
        @last_fetched = Time.current.to_i
        result = HTTPClient.get(url)
        result.body
      end

      def parse_crawling_count(html)
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
          next if a_tag.attribute('href').nil? || a_tag.attribute('href')[0].try(:value).nil?
          { name:   a_tag.text,
            import: "#{livefans_root}#{a_tag.attribute('href')[0].value}" }
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
