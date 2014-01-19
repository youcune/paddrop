class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user

  # ログインしていない場合はトップページに飛ばす
  def require_login
    if @user.blank?
      flash[:danger] = 'Dropboxアカウントでサインインしてください！'
      redirect_to root_path
    end
  end

  # DropboxClientを返す
  # @return [DropboxClient]
  def dropbox_client
    return nil if @user.nil?
    DropboxClient.new(@user.access_token)
  end

  private
    def set_user
      cookie = cookies[:paddrop_sid]
      @user = cookie.present? ? User.session_login(cookie) : nil
    end
end
