class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ログインユーザを返す
  # @return [User | nil] user
  def logged_in_user
    cookie = cookies[:paddrop_sid]
    return nil if cookie.blank?

    User.session_login(cookie)
  end

  # ログインしているかどうかを返す
  # @return [Boolean] ログインしている場合true
  def logged_in?
    logged_in_user.present?
  end

  # ログインしていない場合はトップページに飛ばす
  def require_login
    redirect_to root_path unless logged_in?
  end

  # DropboxClientを返す
  # @return [DropboxClient]
  def dropbox_client
    user = logged_in_user
    return nil if user.nil?

    DropboxClient.new(user.access_token)
  end
end
