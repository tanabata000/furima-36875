class ItemsController < ApplicationController
  # 未ログインユーザーをログインページにリダイレクトする。例外アクション[:index, :show]
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end
  
  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:user, :image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
