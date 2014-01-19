require 'dropbox_sdk'

class FilesController < ApplicationController
  before_action :setup

  def get
    if Content.dir?(@user, @path)
      @files = Content.ls(@user, @path)
      render action: :index
    else
      @content = Content.less(@user, @path)
      render action: :show, formats: :html
    end
  end

  def setup
    require_login
    # 先頭と末尾のスラッシュをとる
    # ユーザに見せるためにURLにはスラッシュをつけるが、内部では全部取って扱う
    @path = URI.unescape(request.path.force_encoding('UTF-8')).sub(/^\/files\/?/, '')
    @client = dropbox_client
  end
end
