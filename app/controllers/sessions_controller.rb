class SessionsController < ApplicationController

    def index
      if session[:user_id] != nil
        # if user tries to go to /sessions/new and is already logged in, send them to /notes/index
        redirect_to notes_url
      else
        redirect_to new_session_path
      end
    end

    def new
      if session[:user_id] != nil
        redirect_to notes_url
      end
    end

    def create
      # Authenticate user
      @user = User.authenticate(params[:email], params[:password])
      if @user
        # if user is authenticated send to /notes/index and save user_id in session
        session[:user_id] = @user.id
        redirect_to notes_url
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end

    def destroy
      # Destroy session data when user logs out and send them to /sessions/new
      session[:user_id] = nil
      session[:note_id] = nil
      @user = nil
      redirect_to root_url, :notice => "Logged out!"
      reset_session
    end
end
