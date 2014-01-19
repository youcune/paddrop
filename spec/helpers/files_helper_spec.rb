require 'spec_helper'

describe FilesHelper do
  describe '#path_to' do
    it '/ to /files/' do
      c = Content.new(dir: '', name: '', is_dir: '1')
      expect(path_to(c)).to eq '/files/'
    end

    it '/documents/ to /files/documents/' do
      c = Content.new(dir: '', name: 'documents', is_dir: '1')
      expect(path_to(c)).to eq '/files/documents/'
    end

    it '/documents/work/ to /files/documents/work/' do
      c = Content.new(dir: 'documents', name: 'work', is_dir: '1')
      expect(path_to(c)).to eq '/files/documents/work/'
    end

    it '/documents/file.txt to /files/documents/files.txt' do
      c = Content.new(dir: 'documents', name: 'files.txt', is_dir: '0')
      expect(path_to(c)).to eq '/files/documents/files.txt'
    end

    it '/documents/work/file.txt to /files/documents/work/files.txt' do
      c = Content.new(dir: 'documents/work', name: 'files.txt', is_dir: '0')
      expect(path_to(c)).to eq '/files/documents/work/files.txt'
    end

    it '/書類/仕事/ファイル.txt to /files/%E6%9B%B8%E9%A1%9E/%E4%BB%95%E4%BA%8B/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB.txt' do
      c = Content.new(dir: '書類/仕事', name: 'ファイル.txt', is_dir: '0')
      expect(path_to(c)).to eq '/files/%E6%9B%B8%E9%A1%9E/%E4%BB%95%E4%BA%8B/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB.txt'
    end
  end

  describe '#breadcrumb_elements' do
    it '/' do
      expected = [
        ['Dropbox', nil],
      ]
      expect(breadcrumb_elements('')).to eq expected
    end

    it '/documents/' do
      expected = [
        ['Dropbox', '/'],
        ['documents', nil],
      ]
      expect(breadcrumb_elements('documents')).to eq expected
    end

    it '/documents/work/' do
      expected = [
        ['Dropbox', '/'],
        ['documents', '/documents/'],
        ['work', nil],
      ]
      expect(breadcrumb_elements('documents/work')).to eq expected
    end

    it '/documents/file.txt' do
      expected = [
        ['Dropbox', '/'],
        ['documents', '/documents/'],
        ['file.txt', nil],
      ]
      expect(breadcrumb_elements('documents/file.txt')).to eq expected
    end

    it '/documents/work/file.txt' do
      expected = [
        ['Dropbox', '/'],
        ['documents', '/documents/'],
        ['work', '/documents/work/'],
        ['file.txt', nil],
      ]
      expect(breadcrumb_elements('documents/work/file.txt')).to eq expected
    end

    it '/書類/仕事/ファイル.txt' do
      expected = [
        ['Dropbox', '/'],
        ['書類', '/%E6%9B%B8%E9%A1%9E/'],
        ['仕事', '/%E6%9B%B8%E9%A1%9E/%E4%BB%95%E4%BA%8B/'],
        ['ファイル.txt', nil],
      ]
      expect(breadcrumb_elements('書類/仕事/ファイル.txt')).to eq expected
    end
  end
end
