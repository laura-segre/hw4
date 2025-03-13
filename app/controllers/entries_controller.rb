class EntriesController < ApplicationController
  before_action :require_login

  def index
    # Only show entries created by the logged-in user
    @entries = Entry.where(user_id: session["user_id"])
  end

  def new
    @entry = Entry.new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["uploaded_image"]=params["uploaded_image"]
      @entry["user_id"] = user["id"]
      @post.save
    else
      flash["notice"] = "Login first."
    end
      redirect_to "/places"
    end

    def show
      # Prevent users from seeing other users' entries
      @entry = Entry.find_by(id: params[:id], user_id: session[:user_id])
      if @entry.nil?
        redirect_to entries_path, alert: "You are not authorized to view this entry."
      end
    end
  
    private
  
    def entry_params
      params.require(:entry, :title, :description, :occurred_on, :place_id, :uploaded_image)
    end
  
    def require_login
      unless session[:user_id]
        flash[:alert] = "You must be logged in to access this section."
        redirect_to login_path
      end
    end
  end