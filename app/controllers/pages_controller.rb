# frozen_string_literal: true

class PagesController < ApplicationController
  def index
   @link = Link.new
  end
end
