# -*- encoding: utf-8 -*-

require 'spec_helper'

describe Content do
  describe '#split_path' do
    it '/file.txt' do
      expected = ['', 'file.txt']
      actual = Content.split_path('/file.txt')
      expect(actual).to eq expected
    end

    it '/documents/file.txt' do
      expected = ['documents', 'file.txt']
      actual = Content.split_path('/documents/file.txt')
      expect(actual).to eq expected
    end

    it '/documents/work/file.txt' do
      expected = ['documents/work', 'file.txt']
      actual = Content.split_path('/documents/work/file.txt')
      expect(actual).to eq expected
    end

    it '/Documents/Work/File.txt' do
      expected = ['documents/work', 'File.txt']
      actual = Content.split_path('/documents/work/File.txt')
      expect(actual).to eq expected
    end
  end
end
