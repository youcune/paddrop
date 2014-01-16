class Session < ActiveRecord::Base
  belongs_to :user

  # expires_atを延長して保存する
  def save
    if self.new_record?
      self.sid = generate_sid
    end

    self.expires_at = generate_expires_at
    super
  end

  def save!
    self.save || raise(RecordNotSaved)
  end

  private
  # sidを生成して返す
  # @return [String] sid
  def generate_sid
    ((0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a).sample(16).join
  end

  # expires_atを生成して返す
  # @return [ActiveSupport::TimeWithZone] expires_at
  def generate_expires_at
    90.days.since
  end
end
