require 'dropbox_sdk'

class UsersController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  def get_dropbox_oauth
    DropboxOAuth2Flow.new(
      ENV['consumer_key'],
      ENV['consumer_secret'],
      Paddrop::Application.config.dropbox_redirect_uri,
      session,
      :dropbox_auth_csrf_token,
      'ja'
    )
  end

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    redirect_to get_dropbox_oauth.start
  end

  # GET /sessions/1/edit
  def edit
  end

  # GET /sessions/create
  def create
    access_token = get_dropbox_oauth.finish(params)[0]
    @files = DropboxClient.new(access_token).metadata('/')['contents'].map{ |f| f['path'] }

    #respond_to do |format|
    #  if @session.save
    #    format.html { redirect_to @session, notice: 'Session was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @session }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @session.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @session }
      else
        format.html { render action: 'edit' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params[:session]
    end
end
