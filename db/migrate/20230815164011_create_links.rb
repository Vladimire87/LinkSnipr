# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.text :original_url

      t.timestamps
    end
  end
end
