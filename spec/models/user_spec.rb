# -*- encoding: utf-8 -*-

require 'spec_helper'
require 'models/user'

describe User do

  # TODO auto-generated
  describe '#dropbox_login' do
    it 'works' do
      dropbox = double('dropbox')
      result = User.dropbox_login(dropbox)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#session_login' do
    it 'works' do
      cookie = double('cookie')
      result = User.session_login(cookie)
      expect(result).not_to be_nil
    end
  end

end
