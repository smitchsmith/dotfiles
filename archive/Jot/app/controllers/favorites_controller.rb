class FavoritesController < ApplicationController

  def index
    @user = User.find(params[:id])
    @favorite_pages = @user.favorite_pages
  end

  def create
    favorite = Favorite.new(params[:favorite])

    if favorite.user_id == current_user.id
      # UserMailer.favorite(page).deliver! if page.owner
      favorite.save!
      render json: favorite
    else
      render json: { user: "User mismatch!" }, status: 422
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    if favorite.user_id == current_user.id
      favorite.destroy
      render json: favorite
    else
      render json: { user: "User mismatch!" }, status: 422
    end
  end

end
