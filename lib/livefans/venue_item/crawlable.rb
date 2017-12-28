# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'url_helper'

module Livefans
  module VenueItem
    module Crawlable # :nodoc:
      include Livefans::UrlHelper

      def crawl_venue_item_all
        ::Venue.find_each(batch_size: 100).each do |v|
          data = crawl_venue_item v
          begin
            v.update(data)
          rescue ActiveRecord::ActiveRecordError => e
            puts e.message
            e.backtrace.each { |m| puts m }
            next
          end
        end
      end

      def crawl_venue_item(venue)
        html = fetch_page(venue.import)
        parse_venue_item html
      end

      def parse_venue_item(html)
        oga = Oga.parse_html(html)
        html_venue = oga.xpath('html/body/div/div/div/div/div/section').first
        iframe =   html_venue.children[1]
        tbody =    html_venue.children[7].children[1]
        a = parse_address(slice_venue_item(tbody.children[1].text))
        zipcode =  a[:zipcode]
        address =  a[:address]
        access =   slice_venue_item(tbody.children[3].text)
        latlang =  parse_latlang(iframe.attributes[1].value)
        capacity = slice_venue_item(tbody.children[5].text)
        url =      tbody.children[11].children[3].children[0].attribute('href').value
        { address: address, zipcode: zipcode, access: access, latlang: latlang, capacity: capacity, url: url }
      rescue
        {}
      end

      private

      def slice_venue_item(text)
        text.split("\n").reject(&:empty?).drop(1).map(&:strip).join(' ')
      rescue
        ''
      end

      def parse_address(text)
        r = text.match(/(〒)(\d{3}-\d{4})(.*)/)
        { zipcode: r[2].delete('-'),
          address: r[3] }
      rescue
        ''
      end

      def parse_latlang(text)
        lat  = text.match(/latitude=([\d\.]*)/)[1]
        lang = text.match(/longitude=([\d\.]*)/)[1]
        "#{lat}-#{lang}"
      rescue
        ''
      end
    end
  end
end
