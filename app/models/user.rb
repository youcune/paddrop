class User < ActiveRecord::Base
  has_many :sessions

  default_scope { where(is_deleted: false) }

  # Userをsaveし、ひもづくsessionを作成する
  def save
    super

    Session.login
  end

  # Dropboxからの戻り値を判断してログインする
  # @param [Array] dropbox
  # @return [User] user
  def self.dropbox_login(dropbox, request)
    user = User.where(user_id: dropbox[1]) || User.new
    user.user_id = dropbox[1]
    user.access_token = dropbox[0]
    user.created_by ||= request.remote_host
    user.updated_by = request.remote_host
    user.save
  end
end
