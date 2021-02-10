class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @sekais = @user.sekais
    @sekai = Sekai.new
  end
end
