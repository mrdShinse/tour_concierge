# frozen_string_literal: true

class ChangeColumnOnVenueAccess < ActiveRecord::Migration[5.1] # :nodoc:
  def up
    change_column :venues, :access, :text, null: true, after: :address
    change_column :venues, :url,    :text, null: true, after: :capacity
  end

  def down
    change_column :venues, :access, :string, null: true, after: :address
    change_column :venues, :url,    :string, null: true, after: :capacity
  end
end
