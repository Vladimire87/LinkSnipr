# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @link = Link.new
    @shortened_links = session[:shortened_links] || []
  end
end
