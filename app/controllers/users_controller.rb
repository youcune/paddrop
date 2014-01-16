require 'dropbox_sdk'

class UsersController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  def get_dropbox_client
    DropboxClient.new()
  end

  # GET /setting
  def setting
    @files = (user.access_token).metadata('/')['contents'].map{ |f| f['path'] }
    render action: :create
  end
end
