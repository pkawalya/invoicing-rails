# frozen_string_literal: true

class AddUnaccent < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    enable_extension 'unaccent'
  end
end
