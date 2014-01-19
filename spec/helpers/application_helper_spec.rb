require 'spec_helper'
require 'date'

describe ApplicationHelper do
  describe '#display_size' do
    it '0の場合は-返す (0 to -)' do
      expect(display_size(0)).to eq '-'
    end

    it '0.8に満たないときはそのままの単位で返す (819 to 819 Bytes)' do
      expect(display_size(819)).to eq '819 Bytes'
    end

    it '0.8以上のときは大きい単位で返す (820 to 0.8 KB)' do
      expect(display_size(820)).to eq '0.8 KB'
    end

    it '四捨五入が行われる (1024 - 52 to 0.9 KB)' do
      expect(display_size(1024 - 52)).to eq '0.9 KB'
    end

    it '四捨五入が行われる (1024 - 51 to 1.0 KB)' do
      expect(display_size(1024 - 51)).to eq '1.0 KB'
    end

    it '四捨五入が行われる (1024 * 100 - 52 to 100KB)' do
      expect(display_size(1024 * 100 - 52)).to eq '99.9 KB'
    end

    it '四捨五入が行われる (1024 * 100 - 51 to 100KB)' do
      expect(display_size(1024 * 100 - 51)).to eq '100 KB'
    end

    it 'MB単位で返す (1024 * 1024 * 100 to 100 MB)' do
      expect(display_size(1024 * 1024 * 100)).to eq '100 MB'
    end

    it 'GB単位で返す (1024 * 1024 * 1024 * 100 to 100 GB)' do
      expect(display_size(1024 * 1024 * 1024 * 100)).to eq '100 GB'
    end
  end

  describe '#display_datetime' do
    it 'yyyy/mm/dd hh:mm 形式で返す' do
      dt = DateTime.new(2014, 1, 19, 13, 5, 5)
      expect(display_datetime(dt)).to eq '14/01/19 13:05'
    end
  end
end
