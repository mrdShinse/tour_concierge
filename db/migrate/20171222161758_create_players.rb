# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    create_table :players do |t|
      t.string :name,   null: false, comment: 'アーティスト名'
      t.string :import, null: false, comment: 'インポート元'

      t.timestamps

      t.index %i[import]
    end
  end
end
