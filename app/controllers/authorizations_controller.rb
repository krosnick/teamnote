class AuthorizationsController < ApplicationController
  before_action :set_auth, only: [:edit, :update, :destroy]
  before_action :require_login

  def index
    session[:note_id] ||= params[:note_id]
  end

  def new
  	if(session[:note_id] == nil)
        redirect_to authorizations_url
    else
        @auth = Authorization.new
    end
  end

  def edit
    @email = User.find(@auth.user_id).email
  end

  def update
    @auth.access = params[:level]
    if @auth.save
      redirect_to authorizations_url, :notice => "Permission updated!"
    else
      redirect_to edit_authorization_path(@auth.id), :notice => "Permission updated!"
    end
  end

  def create
  	user_given_access = User.find_by_email(params[:email])
  	if user_given_access != nil
      matches = Authorization.where("user_id = ? AND note_id = ?", user_given_access.id, session[:note_id])
      if matches.length > 0
        redirect_to new_authorization_path, :notice => "You've already shared this note with this user"
      else
        @auth = Authorization.new
        @auth.user_id = user_given_access.id
        @auth.note_id = session[:note_id]
        @auth.given_access_by = current_user.id
        @auth.access = params[:level]

        if @auth.save
          redirect_to authorizations_url, :notice => "Note shared!"
        else
          redirect_to new_authorization_path, :notice => "There was a problem" 
        end
      end
  	else
  		redirect_to new_authorization_path, :notice => "Invalid email address"
  	end
  end

  def destroy
    @auth.destroy
    respond_to do |format|
      format.html { redirect_to authorizations_url }
      format.json { head :no_content }
    end
  end

  private
    def require_login
      if session[:user_id] == nil
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_url
      end
    end
    def set_auth
      @auth = Authorization.find(params[:id])
    end
    def radio_button_value(level)
      if (level == @auth.access).eql?(true)
        return true
      else
        return false
      end
    end
    helper_method :radio_button_value
end
