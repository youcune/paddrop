module FilesHelper
  def path_to(content)
    path = '/files'
    path += "/#{content.dir}" if content.dir.present?
    path += "/#{content.name}" if content.name.present?
    path += '/' if content.dir?
    URI.escape path
  end

  # 現在いるパスからパンくずリストを出力するためのArrayを生成
  # @param [String] current_path
  # @return [Array] [ラベル, パス] のArray
  def breadcrumb_elements(current_path)
    if current_path.present?
      paths = "/#{current_path}".split('/')
    else
      paths = ['']
    end
    elements = []
    paths.each_with_index do |p, i|
      # 最初の要素の場合ラベルは「Dropbox」にする
      label = i == 0 ? 'Dropbox' : p

      # 最後の要素の場合リンクしない
      path = paths.length - 1 == i ? nil : URI.escape("#{paths[0 .. i].join('/')}/")

      elements << [label, path]
    end
    elements
  end
end
