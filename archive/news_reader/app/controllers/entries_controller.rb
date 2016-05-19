class EntriesController < ApplicationController
  def index
    feed = Feed.find(params[:feed_id])

    if feed.updated_at < 2.minutes.ago
      feed.reload
    end

    render :json => feed.entries
  end
end
