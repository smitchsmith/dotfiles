class TracksController < ApplicationController

  def index
    @album = Album.find(params[:id])
    @tracks = @album.tracks
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
    @notes = @track.notes
  end

  def new
    @album = Album.find(params[:id])
    @track = Track.new
    @albums = Album.all
  end

  def create
    track = Track.new(params[:track])
    track.save!
    redirect_to track_url(track)
  end

  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    @albums = Album.all
  end

  def update
    track = Track.find(params[:id])
    track.update_attributes!(params[:track])
    redirect_to track_url(track)
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy!
    redirect_to album_url(track.album)
  end
end