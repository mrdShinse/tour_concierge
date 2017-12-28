# frozen_string_literal: true

class AddZipcodeToVenue < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :venues, :zipcode, :string, null: true, limit: 7, after: :name, comment: '郵便番号'
  end
end
