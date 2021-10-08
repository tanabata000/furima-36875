class ItemsController < ApplicationController
  # 未ログインユーザーをログインページにリダイレクトする。例外アクション[:index, :show]
  # 下記のコードでも実行可能。使用する際はprivateに記載されているmove_to_indexメソッドもコメントアウト解除
  # before_action :move_to_index, except: [:index, :show]

  before_action :authenticate_user!, except: [:index, :show]

  def index
    # 【SQLの内容】テーブル（items）選択。降順に並べ替える（投稿が新しい順）
    query = 'SELECT * FROM items ORDER BY created_at DESC'
    # SQL使用（対象：Item 実行内容：query）
    @items = Item.find_by_sql(query)
    # @items = Item.order("created_at DESC")
  end

  def new
    # モデル新規レコード作成、@変数に代入
    @item = Item.new
  end

  def create
    # モデル新規レコードにパラメータを入力し保存
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit    
    @item = Item.find(params[:id])
    # 出品者のみ編集可能。ただし購入済みの場合、出品者でも編集不可
    # ログイン中のユーザーと出品者が違う場合
    if current_user != @item.user
      redirect_to root_path
    else
      # 製品が購入されている場合、一覧画面に遷移
      if @item.buy_item_info.present? == true
        redirect_to root_path
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_info, :item_category_id, :item_sales_status_id,
                                 :item_shipping_fee_status_id, :item_prefecture_id, :item_scheduled_delivery_id, :item_price).merge(user_id: current_user.id)
  end

  # 下記はauthenticate_user!では細かい指定ができない場合に使用
  # def move_to_index
  # unless user_signed_in?
  # redirect_to new_user_session_path
  # end
  # end
end
