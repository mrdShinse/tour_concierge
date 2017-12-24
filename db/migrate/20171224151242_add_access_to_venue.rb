# frozen_string_literal: true

class AddAccessToVenue < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :venues, :access, :string, null: true, after: :address, comment: 'アクセス'
  end
end
