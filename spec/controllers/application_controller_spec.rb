# -*- encoding: utf-8 -*-

require 'spec_helper'
require 'controllers/application_controller'

describe ApplicationController do

  # TODO auto-generated
  describe '#logged_in_user' do
    it 'works' do
      application_controller = ApplicationController.new
      result = application_controller.logged_in_user
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#logged_in?' do
    it 'works' do
      application_controller = ApplicationController.new
      result = application_controller.logged_in?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#require_login' do
    it 'works' do
      application_controller = ApplicationController.new
      result = application_controller.require_login
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#dropbox_client' do
    it 'works' do
      application_controller = ApplicationController.new
      result = application_controller.dropbox_client
      expect(result).not_to be_nil
    end
  end

end
