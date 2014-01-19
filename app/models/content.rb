require 'Date'
require 'dropbox_sdk'

class Content < ActiveRecord::Base
  belongs_to :user
  default_scope { where('created_at > ?', DateTime.now - 1.hour) }

  def dir?
    self.is_dir == '1'
  end

  def file?
    self.is_dir == '0'
  end

  # Dropbox Clientからの戻り値contentからモデルを生成する
  def self.new_by_dropbox_content(user_id, dropbox_content)
    dir, name = Content.split_path(dropbox_content['path'])
    Content.new(
      user_id: user_id,
      dir: dir,
      name: name,
      is_dir: dropbox_content['is_dir'] ? '1' : '0',
      bytes: dropbox_content['bytes'],
      modified_at: DateTime.parse(dropbox_content['modified'])
    )
  end

  # キャッシュまたはDropbox Clientからファイルリストを返す
  # @param [User] user
  # @param [String] dir
  # @return [Array] contents
  def self.ls(user, dir)
    if Content.where(user_id: user.id, dir: dir.downcase).count.zero?
      Rails.logger.info("Getting metadata from Dropbox. user_id: #{user.id}, dir: #{dir}")
      ActiveRecord::Base.transaction do
        DropboxClient.new(user.access_token).metadata(dir)['contents'].each do |c|
          Content.new_by_dropbox_content(user.id, c).save!
        end
      end
    else
      Rails.logger.info("Skipped to get from Dropbox. user_id: #{user.id}, dir: #{dir}")
    end

    Content.where(user_id: user.id, dir: dir.downcase).order(is_dir: :desc, name: :asc)
  end

  def self.split_path(path)
    path =~ /^\/?(.*)\/([^\/]+)/
    [$1.downcase, $2]
  end
end
