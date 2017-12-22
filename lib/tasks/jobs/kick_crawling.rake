# frozen_string_literal: true

namespace :jobs do
  desc 'kick job.'
  task :kick_search_venues_list, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    Livefans::SearchVenuesListJob.perform_now
    puts "#{'*' * 10} finished."
  end

  desc 'kick job.'
  task :kick_search_artists_list, %i[] => :environment do |_t, _args|
    puts "#{'*' * 10} starting."
    Livefans::SearchArtistsListJob.perform_now
    puts "#{'*' * 10} finished."
  end
end
