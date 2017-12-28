# frozen_string_literal: true

class AddLatitudeAndLongitudeToVenue < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :venues, :latitude,  :float, limit: 30, after: :latlang,  comment: '緯度'
    add_column :venues, :longitude, :float, limit: 30, after: :latitude, comment: '経度'

    add_index  :venues, %i[latitude longitude]
  end
end
