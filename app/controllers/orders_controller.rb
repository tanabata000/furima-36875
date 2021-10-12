class OrdersController < ApplicationController
  # メソッドのセットアップ
  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]
  before_action :order_new, only: [:index]

  def index
    redirect_to root_path if @item.buy_item_info.present? == true
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      # 決済処理に関するメソッド（privateに記述）
      pay_item
      @order.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    # order_params[:price]としてpriceの情報をorder_params[:token]としてtokenの情報が取得できるように設定
    params.require(:order).permit(:postal_code, :item_prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], item_price: @item.item_price, token: params[:token]
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def order_new
    @order = Order.new
  end

  def pay_item
    # 環境変数に代入したPAY.JPテスト秘密鍵を呼び出す記述
    # Payjpクラスのインスタンス（api_key）を呼び出し、秘密鍵を代入
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # 下記のように秘密鍵を記述するとGitHubから見えてしまうためNG
    # Payjp.api_key = "sk_test_***********"
    Payjp::Charge.create(
      # 商品の値段
      amount: order_params[:item_price],
      # カードトークン
      card: order_params[:token],
      # 通貨の種類（日本円）
      currency: 'jpy'
    )
  end
end
