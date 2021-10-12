class ItemsController < ApplicationController
  # 未ログインユーザーをログインページにリダイレクトする。例外アクション[:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, except: [:index, :new, :create]
  before_action :move_to_index, only: [:edit, :destroy]

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
    # 製品が購入されている場合、一覧画面に遷移
    redirect_to root_path if @item.buy_item_info.present? == true
  end

  def update
    if @item.update(item_params)
      redirect_to item_path, method: :get
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_info, :item_category_id, :item_sales_status_id,
                                 :item_shipping_fee_status_id, :item_prefecture_id, :item_scheduled_delivery_id, :item_price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  # ログインユーザーと出品者が一致しない場合、一覧ページに遷移
  def move_to_index
    redirect_to root_path if current_user != @item.user
  end
end
