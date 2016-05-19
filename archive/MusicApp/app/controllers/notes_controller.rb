class NotesController < ApplicationController

  def new
  end

  def create
    track = Track.find(params[:id])

    note = params[:note]
    note[:user_id] = self.current_user.id
    note[:track_id] = track.id
    Note.create!(note)

    redirect_to track_url(track)
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy!
    redirect_to track_url(note.track)
  end
end