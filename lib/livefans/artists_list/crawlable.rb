# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module ArtistsList
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_artists_list
        artists_list = Kana.ids.map { |id| crawl_artists_list_by_kana id }.flatten
        artists_list.compact.each do |artist|
          next if artist.empty?
          Artist.find_or_initialize_by(import: artist[:import]) { |v| v.update(artist) }
        end
      end

      def crawl_artists_list_by_kana(code)
        count = parse_artists_list_crawling_count(
          fetch_page(artists_list_path(code, 1))
        )
        data = count.times.map do |c|
          parse_artists_list(
            fetch_page(artists_list_path(code, c + 1))
          )
        end
        data.flatten
      end

      def parse_artists_list_crawling_count(html)
        oga = Oga.parse_html(html)
        paginations = oga.xpath('html/body/div/div/p/span')
        pagination_last = paginations[paginations.size - 2]
        return 1 unless pagination_last
        pagination_last.try(:text).try(:to_i)
      end

      def parse_artists_list(html)
        oga = Oga.parse_html(html)
        html_artists = oga.xpath('html/body/div/div/div')
        html_artists.map do |artist|
          a_tag = artist.xpath('h3/a')
          return nil if a_tag.attribute('href').nil? || a_tag.attribute('href')[0].try(:value).nil?
          { name:   a_tag.text,
            import: "#{livefans_root_url}#{a_tag.attribute('href')[0].value}" }
        end
      end
    end
  end
end
