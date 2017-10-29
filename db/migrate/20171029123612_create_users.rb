# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
