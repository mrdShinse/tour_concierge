# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module EventsList
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_events_list_by_artist(artist)
        import_id = artist.import.split('/').last
        count = parse_events_list_crawling_count fetch_page(events_list_path(import_id, 1))
        data = count.times.map do |c|
          parse_events_list(fetch_page(events_list_path(import_id, c + 1)), import_id)
        end
        data.flatten.compact.each do |event|
          next if event.empty?
          ::Event.find_or_initialize_by(import: event[:import]) { |e| e.update(event) }
        end
      end

      def parse_events_list_crawling_count(html)
        oga = Oga.parse_html(html)
        count_text = oga.xpath('html/body/div/div/div/h3/span').text
        return 1 unless count_text
        count = count_text.delete('件').try(:to_i)
        return 1 unless count
        count / 20 + 1
      rescue
        1
      end

      def parse_events_list(html, artist_id)
        oga = Oga.parse_html(html)
        event_list = oga.xpath('html/body/div/div/div/div/div')
                        .select { |e| e.attribute('class').try(:value) == 'whiteBack midBox fes' }
        event_list.map do |e|
          { import: "#{livefans_root_url}#{e.children[1].attribute('href').value}",
            artist_id: artist_id,
            name: e.xpath('h3')[0].text }
        end
      rescue
        []
      end
    end
  end
end
