# -*- encoding: utf-8 -*-

require 'spec_helper'

describe Content do

  # TODO auto-generated
  describe '#new' do
    it 'works' do
      dropbox_content = double('dropbox_content')
      result = Content.new(dropbox_content)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#dir?' do
    it 'works' do
      dropbox_content = double('dropbox_content')
      content = Content.new(dropbox_content)
      result = content.dir?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#file?' do
    it 'works' do
      dropbox_content = double('dropbox_content')
      content = Content.new(dropbox_content)
      result = content.file?
      expect(result).not_to be_nil
    end
  end

  describe '#split_path' do
    it '/file.txt' do
      expected = ['/', 'file.txt']
      actual = Content.split_path('/file.txt')
      expect(actual).to eq expected
    end

    it '/documents/file.txt' do
      expected = ['/documents/', 'file.txt']
      actual = Content.split_path('/documents/file.txt')
      expect(actual).to eq expected
    end

    it '/documents/work/file.txt' do
      expected = ['/documents/work/', 'file.txt']
      actual = Content.split_path('/documents/work/file.txt')
      expect(actual).to eq expected
    end
  end
end
