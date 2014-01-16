require 'dropbox_sdk'

class SessionsController < ApplicationController
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

  # GET /sign_in
  def sign_in
    redirect_to get_dropbox_oauth.start
  end

  # GET /setting
  def edit
    @files = DropboxClient.new(user.access_token).metadata('/')['contents'].map{ |f| f['path'] }
    render action: :create
  end

  # GET /authorize
  def authorize
    begin
      dropbox_tuple = get_dropbox_oauth.finish(params)
    rescue
      flash[:danger] = 'Dropbox認証エラーです。再度お試しください。'
      redirect_to root_path
    end

    begin
      user, session = User.dropbox_login(dropbox_tuple)
    rescue => e
      flash[:danger] = '認証には成功しましたが、後続処理のエラーです。再度お試しください。'
      redirect_to root_path
    end

    cookies[:paddrop_sid] = { value: session.sid, expires: 90.days.since }

    if user.default_path.nil?
      redirect_to edit_user_path
    else
      redirect_to browse_path
    end

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

  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
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

  # DELETE /user/1
  # DELETE /user/1.json
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
