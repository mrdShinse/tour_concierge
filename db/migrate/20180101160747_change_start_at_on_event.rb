# frozen_string_literal: true

class ChangeStartAtOnEvent < ActiveRecord::Migration[5.1] # :nodoc:
  def up
    change_column :events, :start_at, :datetime, null: true, after: :name, comment: '開始時間'
  end

  def down
    change_column :events, :start_at, :time, null: true, after: :name, comment: '開始時間'
  end
end
