# frozen_string_literal: true

class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
    require 'rqrcode'

    qrcode = RQRCode::QRCode.new(@link.original_url)

    @svg = qrcode.as_svg(
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 3,
      standalone: true,
      use_path: true
    )
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
      render file: "#{Rails.public_path.join('404.html')}", status: :not_found, layout: false
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
