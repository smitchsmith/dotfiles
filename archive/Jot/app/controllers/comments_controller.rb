class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.owner_id = current_user.id if current_user
    @comment.save!
    render json: build_json
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: build_json
  end

  # private

  def build_json
    Jbuilder.encode do |json|
      json.(@comment, :owner_id, :page_id, :body, :created_at, :updated_at, :id)
      json.username @comment.owner.username
      json.owner_id @comment.owner.id
    end
  end

end
