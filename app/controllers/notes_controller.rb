class NotesController < ApplicationController
  before_action :set_note, only: [:open, :view, :edit, :update, :destroy]
  before_action :require_login
  before_action :reset_note_session, only: [:index, :new, :destroy]

  def index

  end

  def shared

  end

  def show

  end

  def new
    @note = Note.new
    @auth = Authorization.new
  end

  def open
    # first check to make sure user owns specified note
    if (@note.users.select{ |u| u.id === session[:user_id]}).length != 1
      redirect_to new_session_url
    end
    logger.fatal "OPEN"
    session[:note_id] = @note.id
    auth = Authorization.where("user_id = ? AND note_id = ?", session[:user_id], session[:note_id])[0]
    if auth.access == "write" || auth.access == "author"
      logger.fatal "EDIT"
      redirect_to edit_note_path(@note)
    else
      logger.fatal "VIEW"
      redirect_to view_note_path(@note)
    end
  end

  def view
    # first check to make sure user owns specified note
    respond_to do |format|
      format.html 
      format.json { render json: @note } 
    end
    if (@note.users.select{ |u| u.id === session[:user_id]}).length != 1
      redirect_to new_session_url
    end
    session[:note_id] = @note.id
  end

  def edit
    # first check to make sure user owns specified note
    respond_to do |format|
      format.html 
      format.json { render json: @note } 
    end
    if (@note.users.select{ |u| u.id === session[:user_id]}).length != 1
      redirect_to new_session_url
    end
    session[:note_id] = @note.id
  end

  # occurs when the "Create Note" button is clicked on "new"
  def create
    @note = Note.new(note_params)
    #@note.user_id = current_user.id
    @auth = Authorization.new
    @auth.user_id = current_user.id
    @auth.access = "author"
    if @note.save
      #current_user.notes.sort! { |a,b| b.updated_at <=> a.updated_at }
      @auth.note_id = @note.id
      @auth.save
      redirect_to notes_url, :notice => "Note created!" # redirect to index
    else
      redirect_to new_note_url, :notice => "Title field can't be blank" 
    end
  end

  def update
    if @note.update(note_params)
      # redirect to /notes/index
      redirect_to notes_url, :notice => "Note updated!"
    else
      redirect_to edit_note_path(@note.id), :notice => "Title field can't be blank" 
    end
  end

  def destroy
    logger.fatal @note.id
    Authorization.where(:note_id => @note.id).destroy_all
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :title)
    end

    # first check to make sure user is logged in; if they're not logged in they can't see notes
    def require_login
      if session[:user_id] == nil
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_session_url
      end
    end

    def reset_note_session
      session[:note_id] = nil
    end
  
end
