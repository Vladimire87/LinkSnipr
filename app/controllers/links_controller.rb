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
      session[:shortened_links] ||= []
      session[:shortened_links] << @link
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
      @link = Link.new
      @shortened_links = session[:shortened_links] || []
      flash[:notice] = 'Sorry link with that Snipr is dead.'
      render 'pages/index', status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def url_enc
    url_hash_id = Hashids.new(@link.original_url, 5)
    url_hash_id.encode(@link.id)
  end
end
