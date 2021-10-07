class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # パラメータ設定 対象ビュー：sign_up, 対象カラム: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date]
    # name, email, psswordについてはdeviseで管理しているため不要
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date])
  end

  def basic_auth
    # Basic認証を実装(ブロック名 username, password)
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数をRailsアプリケーション側で読み込む設定
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
