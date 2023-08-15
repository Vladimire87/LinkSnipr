class LinksController < ApplicationController
  def show; end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new link_params
    if @link.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end
end
