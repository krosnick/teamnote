class UsersController < ApplicationController
    def new
        if session[:user_id] != nil
            redirect_to notes_url
        else
            @user = User.new
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # user created, session info stored, and user sent to /notes/index
            session[:user_id] = @user.id
            redirect_to notes_url, :notice => "Signed up!"
        else
            render "new"
        end
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation)
        end
end
