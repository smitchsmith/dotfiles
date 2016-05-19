class AlbumsController < ApplicationController
  def index
    @band = Band.find(params[:id])
    @albums = @band.albums
  end

  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks
  end

  def new
    @bands = Band.all
    @band = Band.find(params[:id])
    @album = Album.new
  end

  def create
    album = Album.new(params[:album])
    album.save!
    redirect_to album_url(album)
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    @band = @album.band
  end

  def update
    album = Album.find(params[:id])
    album.update_attributes!(params[:album])
    redirect_to album_url(album)
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy!
    redirect_to band_url(album.band)
  end

  def all_albums
    @bands = Band.all
  end
end