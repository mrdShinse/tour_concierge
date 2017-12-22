# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module ArtistsList
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_artists_list
      end

      def crawl_artists_list_by_kana(code)
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
