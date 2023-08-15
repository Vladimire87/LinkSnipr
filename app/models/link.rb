# frozen_string_literal: true

class Link < ApplicationRecord
  validates :original_url, presence: true

  def url_encode
    url_hash_id = Hashids.new(original_url)
    hash = url_hash_id.encode(id)
  end

  def url_decode
    url_hash_id = Hashids.new(original_url)
    hash = url_hash_id.encode(id)
    url_hash_id.decode(hash)
  end
end
