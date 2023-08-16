# frozen_string_literal: true

class AddSniprToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :snipr, :string
  end
end
