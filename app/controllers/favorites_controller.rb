class FavoritesController < ApplicationController
      before_action :authenticate_user!

  def create
    @sekai = Sekai.find(params[:sekai_id])
    favorite = @sekai.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to sekais_path
  end

  def destroy
    @sekai = Sekai.find(params[:sekai_id])
    favorite = @sekai.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to sekais_path
  end
end
