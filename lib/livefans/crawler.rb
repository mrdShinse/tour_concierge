# frozen_string_literal: true

require Rails.root.join 'lib', 'livefans', 'venues_list', 'crawlable'
require Rails.root.join 'lib', 'livefans', 'artists_list', 'crawlable'

module Livefans
  class Crawler # :nodoc:
    include Livefans::VenuesList::Crawlable
    include Livefans::ArtistsList::Crawlable
  end
end
