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

  # キャッシュまたはDropbox Clientに問い合わせてフォルダかどうかを調べる
  # 現在キャッシュのみサポート
  def self.dir?(user, path)
    dir, name = Content.split_path(path)
    if Content.where(user_id: user.id, dir: dir, name: name).count.zero?
      return true
    end

    Content.where(user_id: user.id, dir: dir, name: name).first.dir?
  end

  # キャッシュまたはDropbox Clientからファイルリストを返す
  # @param [User] user
  # @param [String] dir
  # @return [Array] contents
  def self.ls(user, dir)
    if Content.where(user_id: user.id, dir: dir.downcase).count.zero?
      Rails.logger.info("Getting metadata from Dropbox. user_id: #{user.id}, dir: #{dir}")
      ActiveRecord::Base.transaction do
        Content.get_client(user).metadata(dir)['contents'].each do |c|
          Content.new_by_dropbox_content(user.id, c).save!
        end
      end
    else
      Rails.logger.info("Skipped to get from Dropbox. user_id: #{user.id}, dir: #{dir}")
    end

    Content.where(user_id: user.id, dir: dir.downcase).order(is_dir: :desc, name: :asc)
  end

  # Dropbox Clientに問い合わせてファイルの内容を取得する
  def self.less(user, file)
    Content.safen(Content.get_client(user).get_file(file).force_encoding('UTF-8'))
  end

  private
    def self.split_path(path)
      if path =~ /^\/?(.*)\/([^\/]+)/
        [$1.downcase, $2]
      else
        ['', path]
      end
    end

    def self.get_client(user)
      DropboxClient.new(user.access_token)
    end

    def self.safen(str)
      str = str.gsub(/^(https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+-]+)/, '<a href="\1">\1</a>')
        .gsub(/^([\w\.\+-]+@[\w\+-]+\.[\w]+)/, '<a href="mailto:\1">\1</a>')
        .gsub(/^(0[\d-]{9,15})/, '<a href="tel:\1">\1</a>')
        .gsub(/\n/, '<br>')
        .html_safe
      str
    end
end
