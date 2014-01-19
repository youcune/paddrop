require 'dropbox_sdk'

class FilesController < ApplicationController
  before_action :setup

  def get
    @files = Content.ls(@user, @path)
    render action: :index
  end

  def setup
    require_login
    # 先頭と末尾のスラッシュをとる
    # ユーザに見せるためにURLにはスラッシュをつけるが、内部では全部取って扱う
    @path = URI.unescape(request.path.force_encoding('UTF-8')).sub(/^\/files\/?/, '')
    @client = dropbox_client
  end
end
