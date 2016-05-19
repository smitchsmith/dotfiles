class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.link_id = params[:link_id]

    if @comment.save
      redirect_to link_url(params[:link_id])
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to link_url(params[:link_id])
    end
  end

  def show
    @link = Link.find(params[:link_id])
    @comment = Comment.find(params[:id])
    @comments_by_parent_id = @link.comments_by_parent_id
  end

  def reply
    @parent_comment = Comment.find(params[:id])

    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id

    @comment.link_id = @parent_comment.link_id
    @comment.parent_comment_id = @parent_comment.id

    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to link_url(@comment.link_id)
    end
  end

end
