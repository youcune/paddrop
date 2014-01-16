class User < ActiveRecord::Base
  has_many :sessions

  # Dropboxからの戻り値を判断してログインする
  # @param [Array] dropbox
  # @return [User] user
  # @return [Session] session
  def self.dropbox_login(dropbox)
    ActiveRecord::Base.transaction do
      user = User.where(user_id: dropbox[1]) || User.new
      user.user_id = dropbox[1]
      user.access_token = dropbox[0]
      user.save!

      session = Session.new(user_id: user.id).save!
      [user, session]
    end
  end
end
