class ItemsController < ApplicationController
  # 未ログインユーザーをログインページにリダイレクトする。例外アクション[:index, :show]
  # before_action :authenticate_user!, except: [:index, :show]
  def index
  end
end
