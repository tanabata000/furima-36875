class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def basic_auth
    # Basic認証を実装(ブロック名 username, password)
    authenticate_or_request_with_http_basic do |username, password|
    # 環境変数をRailsアプリケーション側で読み込む設定
    username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  
    end
  end
end
