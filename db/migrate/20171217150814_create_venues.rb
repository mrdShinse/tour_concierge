# frozen_string_literal: true

class CreateVenues < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    create_table :venues do |t|
      t.string :name,     null: false, comment: '会場名'
      t.text   :address,  null: true,  comment: '住所'
      t.string :latlang,  null: true,  comment: '緯度経度'
      t.string :capacity, null: true,  comment: 'キャパシティ'
      t.string :url,      null: true,  comment: '公式URL'
      t.string :import,   null: false, comment: 'インポート元'

      t.timestamps

      t.index %i[import]
    end
  end
end
