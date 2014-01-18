require 'dropbox_sdk'

class FilesController < ApplicationController
  before_action :setup

  def get
    @files = Content.ls(@user, @path)
    render action: :index
  end

  def setup
    require_login
    @user = logged_in_user
    @path = request.path.sub(/^\/files\/?/, '/')
    @client = dropbox_client
  end
end
