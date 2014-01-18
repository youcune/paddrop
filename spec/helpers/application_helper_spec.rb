require 'spec_helper'

describe ApplicationHelper do
  describe '#display_size' do
    it '0 to -' do
      expect(display_size(0)).to eq '-'
    end

    it '819 to 819 Bytes' do
      expect(display_size(819)).to eq '819 Bytes'
    end

    it '820 to 0.8 KB' do
      expect(display_size(820)).to eq '0.8 KB'
    end

    it '1023 to 1.0KB' do
      expect(display_size(1024)).to eq '1.0 KB'
    end

    it '1024 to 1.0KB' do
      expect(display_size(1024)).to eq '1.0 KB'
    end

    it '1024 * 100 - 52 to 100KB' do
      expect(display_size(1024 * 100 - 52)).to eq '99.9 KB'
    end

    it '1024 * 100 - 51 to 100KB' do
      expect(display_size(1024 * 100 - 51)).to eq '100 KB'
    end

    it '1024 * 100 to 100 KB' do
      expect(display_size(1024 * 100)).to eq '100 KB'
    end

    it '1024 * 1024 * 100 to 100 MB' do
      expect(display_size(1024 * 1024 * 100)).to eq '100 MB'
    end

    it '1024 * 1024 * 1024 * 100 to 100 GB' do
      expect(display_size(1024 * 1024 * 1024 * 100)).to eq '100 GB'
    end
  end
end
