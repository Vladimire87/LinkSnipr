# frozen_string_literal: true

class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new link_params
    if @link.save
      @link.snipr = url_enc
      @link.save
      redirect_to link_path @link
    else
      render :new, status: :unprocessable_entity
    end
  end

  def redirect
    hash = params[:hash]

    if (@link = Link.find_by(snipr: hash))
      redirect_to @link.original_url, status: :found, allow_other_host: true
    else
      flash[:warning] = 'We dont have such link'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def url_enc
    url_hash_id = Hashids.new(@link.original_url, 8)
    url_hash_id.encode(@link.id)
  end
end
