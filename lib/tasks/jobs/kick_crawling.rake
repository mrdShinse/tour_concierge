# frozen_string_literal: true

namespace :jobs do
  desc 'kick job.'
  task :kick_search_venues_list, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    Livefans::SearchVenuesListJob.perform_now
    puts "#{'*' * 10} finished."
  end

  desc 'kick job.'
  task :kick_search_venue_item, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    Livefans::SearchVenueItemJob.perform_now
    puts "#{'*' * 10} finished."
  end

  desc 'kick job.'
  task :kick_search_artists_list, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    Livefans::SearchArtistsListJob.perform_now
    puts "#{'*' * 10} finished."
  end

  desc 'kick job.'
  task :kick_search_events_list, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    ::Player.find_each(batch_size: 100).each do |player|
      puts "get #{player.import_id}..."
      Livefans::SearchEventsListJob.perform_now(player)
    end
    puts "#{'*' * 10} finished."
  end
end
