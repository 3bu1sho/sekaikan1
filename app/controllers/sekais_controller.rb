class SekaisController < ApplicationController
    
    def new
    @sekai = current_user.sekais.new #(favorite_params)
    end
    
  def create
    # # １. データを新規登録するためのインスタンス作成
    # sekai = Sekai.new(sekai_params)
    # # ２. データをデータベースに保存するためのsaveメソッド実行
    # sekai.save
    # # ３. トップ画面へリダイレクト
    # redirect_to '/sekais'
    
    @sekai = current_user.sekais.new(sekai_params)
    tag_list = params[:sekai][:tag_name].split(' ')
    if @sekai.save
      tags = []
      tag_list.each do |tag_name|
        tags << Tag.find_or_create_by(tag_name: tag_name)
      end
      @sekai.tags = tags
      # @sekai.save_tag(tag_list)
    redirect_to '/sekais'
    else
    redirect_to '/sekais'
    end
  end
  
  def index
      @user = current_user
      @sekais =  current_user.sekais
      @sekais = Sekai.find(Favorite.group(:sekai_id).order('count(user_id) desc').limit(100).pluck(:sekai_id))
      if @sekais.length < 100
      @sekais_nil = Sekai.includes(:favorites).where( :favorites => { :id => nil } ).limit(100 - @sekais.length)
      else
      @sekais_nil = []
      end
      @sekais.push(@sekais_nil)
      @sekais.flatten!
      #上のコードを実装したい。したのは仮
      #@sekais = Sekai.all
     # sekais = Sekai.includes(:favorites).references(:favorites).group('sekai_id').order('user_id desc').each {|s| puts s.name}
      @tag_list = Tag.all
      # @sekai = current_user.sekais.new
      
  end
  
  def show
      @user = current_user
    @sekai = Sekai.find(params[:id])
    @sekai_tags = @sekai.tags  
    @comment = Comment.new

  end
  
  def edit
    @sekai = Sekai.find(params[:id])
    @tag_list = @sekai.tags  

  end
  
  def update
    @sekai = Sekai.find(params[:id])
    tag_list = params[:sekai][:tag_name].split(' ')
    if @sekai.update(sekai_params)
      tags = []
      tag_list.each do |tag_name|
        tags << Tag.find_or_create_by(tag_name: tag_name)
      end    
      @sekai.tags = tags
    end
    redirect_to sekais_path(@sekai.id)
  end
  
  def destroy
    sekai = Sekai.find(params[:id])  
    sekai.destroy  
    redirect_to sekais_path  
  end
  
  # def favorite_rank
  #   @sekai = current_user.sekais.new(favorite_params)
  #   tag_list = params[:sekai][:tag_name].split(nil)  
  #   if @sekai.save                                         
  #     @sekai.save_tag(tag_list)                         
  #   redirect_to '/sekais'
  #   else
  #   redirect_to '/sekais'
  #   end
  # end
  
  def search
      @user = current_user
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @sekais = @tag.sekais.all           #クリックしたタグに紐付けられた投稿を全て表示
  end
  
  def mysekai
      @user = current_user
      @sekais =  current_user.sekais
      @tag_list = Tag.all
  end
  
  def favindex
      @user = current_user
      @sekais = Sekai.find(Favorite.group(:sekai_id).order('count(user_id) desc').limit(100).pluck(:sekai_id))
      @sekais_nil = Sekai.includes(:favorites).where( :favorites => { :id => nil } ).limit(100 - @sekais.length)
      @sekais.push(@sekais_nil)
      @sekais.flatten!      
      @tag_list = Tag.all
  end

  private
  # ストロングパラメータ
  def sekai_params
    params.require(:sekai).permit(:name, :introduction, :image, :tag_id)
  end
  
  def favorite_params
    params.require(:sekai).permit(:name, :introduction, :image, :tag_id)
  end
    
end
