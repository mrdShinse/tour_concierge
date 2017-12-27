# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    create_table :events do |t|
      t.integer :player_id, null: false, comment: 'アーティストID'
      t.integer :venue_id,  null: true,  comment: '会場ID'
      t.string  :name,      null: true,  comment: 'イベント名'
      t.time    :start_at,  null: true,  comment: '開始時間'
      t.string  :import,    null: false, comment: 'インポート元'

      t.timestamps

      t.index %i[import]
    end
  end
end
