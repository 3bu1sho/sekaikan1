class SekaisController < ApplicationController
    
    def new
        @sekai = Sekai.new
    end
    
  def create
    # １. データを新規登録するためのインスタンス作成
    sekai = Sekai.new(sekai_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    sekai.save
    # ３. トップ画面へリダイレクト
    redirect_to '/sekais'
  end
  
  def index
      @sekais = Sekai.all
  end
  
  def show
    @sekai = Sekai.find(params[:id])
  end
  
  def edit
    @sekai = Sekai.find(params[:id])
  end
  
  def update
    sekai = Sekai.find(params[:id])
    sekai.update(sekai_params)
    redirect_to sekai_path(sekai.id)
  end
  
  def destroy
    sekai = Sekai.find(params[:id])  
    sekai.destroy  
    redirect_to sekais_path  
  end

  private
  # ストロングパラメータ
  def sekai_params
    params.require(:sekai).permit(:name, :introduction)
  end
    
end
