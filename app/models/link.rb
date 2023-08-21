# frozen_string_literal: true

class Link < ApplicationRecord
  validates :original_url, presence: true, format: {
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: 'is not a valid URL'
  }
end
