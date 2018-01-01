# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'venues_list', 'crawlable'
require Rails.root.join 'lib', 'livefans', 'venue_item', 'crawlable'
require Rails.root.join 'lib', 'livefans', 'artists_list', 'crawlable'
require Rails.root.join 'lib', 'livefans', 'events_list', 'crawlable'
require Rails.root.join 'lib', 'livefans', 'event_item', 'crawlable'

module Livefans
  class Crawler # :nodoc:
    include Livefans::VenuesList::Crawlable
    include Livefans::VenueItem::Crawlable
    include Livefans::ArtistsList::Crawlable
    include Livefans::EventsList::Crawlable
    include Livefans::EventItem::Crawlable
  end
end
