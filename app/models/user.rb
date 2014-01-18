class User < ActiveRecord::Base
  has_many :sessions
  has_many :contents

  # Dropboxからの戻り値を判断してログインする
  # @param [Array] dropbox
  # @return [User] user
  # @return [Session] session
  def self.dropbox_login(dropbox)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: dropbox[1]).first || User.new
      user.user_id = dropbox[1]
      user.access_token = dropbox[0]
      user.save!

      session = Session.new(user_id: user.id)
      session.save!
      [user, [user.id, session.sid].join('-')]
    end
  end

  # Sessionを使ってログインする
  # @param [Fixnum] user_id
  # @param [String] sid
  # @return [User | nil] user
  def self.session_login(cookie)
    user_id, sid = cookie.split('-')
    User.joins(:sessions).where(id: user_id, sessions: {sid: sid}).first
  end
end
