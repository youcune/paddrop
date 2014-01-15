class Session < ActiveRecord::Base
  belongs_to :user

  def create_by_user(user)

  end
end
