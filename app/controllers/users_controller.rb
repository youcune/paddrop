require 'dropbox_sdk'

class UsersController < ApplicationController
  before_action :setup

  def update
    @user.default_path = params[:default_path]
    @user.save!
    flash[:success] = 'デフォルトに設定しました！'
    redirect_to "/files/#{@user.default_path}"
  end

  def setup
    require_login
    @user = logged_in_user
  end
end
