module ApplicationHelper
  UNITS = ['Bytes', 'KB', 'MB', 'GB']

  # バイト数から表示用のサイズを返す
  # 1000 Bytesとかださないようにするため、ある程度なら上位の単位で出す
  def display_size(bytes)
    (UNITS.length - 1).downto(0) do |n|
      num = bytes.to_f / 1024 ** n
      next if num < 0.8
      num = num.round(1)
      num_s = num.to_s

      # 単位がBytesまたは3桁のときは小数点以下は表示しない
      if num >= 100 || n == 0
        num_s.sub!(/\.\d/, '')
      end
      return "#{num_s} #{UNITS[n]}"
    end

    return '-' # 0
  end

  def display_datetime(datetime)
    datetime.strftime('%y/%m/%d %H:%M')
  end
end
