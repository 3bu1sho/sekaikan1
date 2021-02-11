class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @sekais = @user.sekais
    @sekai = Sekai.new
    @tag_list = Tag.all
    
      @sekais_fav = Sekai.find(Favorite.group(:sekai_id).order('count(user_id) desc').limit(100).pluck(:sekai_id))
      @sekais_nil = Sekai.includes(:favorites).where( :favorites => { :id => nil } ).limit(100 - @sekais_fav.length)
      @sekais_fav.push(@sekais_nil)
      @sekais_fav.flatten!      
      end
end
