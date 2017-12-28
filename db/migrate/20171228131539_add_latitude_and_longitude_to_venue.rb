# frozen_string_literal: true

class AddLatitudeAndLongitudeToVenue < ActiveRecord::Migration[5.1] # :nodoc:
  def up
    add_column :venues, :latitude,  :float, limit: 30, after: :latlang,  comment: '緯度'
    add_column :venues, :longitude, :float, limit: 30, after: :latitude, comment: '経度'

    add_index  :venues, %i[latitude longitude]

    ::Venue.where.not(latlang: nil).each do |v|
      ll = v.latlang.split('-')
      v.update(latitude: ll[0], longitude: ll[1])
    end

    remove_column :venues, :latlang
  end

  def drop
    add_column :venues, :latlang, null: true, comment: '緯度経度'

    ::Venue.where.not(latitude: nil, longitude: nil).all.each do |v|
      v.update(latlang: "#{v.latitude}-#{v.longitude}")
    end

    remove_column :venues, :latitude
    remove_column :venues, :longitude
  end
end
