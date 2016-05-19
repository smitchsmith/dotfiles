class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
  end

  def new
    @band = Band.new
  end

  def create
    name = params[:band][:name]
    band = Band.create!(name: name)
    redirect_to band_url(band)
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    band = Band.find(params[:id])
    band.update_attributes!(params[:band])
    redirect_to band_url(band)
  end

  def destroy
    band = Band.find(params[:id])
    band.destroy!
    redirect_to bands_url
  end
end