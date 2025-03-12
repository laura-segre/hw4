class EntriesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show]

  def index
    # Only show entries created by the logged-in user
    @entries = Entry.where(user_id: session["user_id"])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session["user_id"] # Assign entry to the logged-in user

    if @entry.save
      redirect_to "/places/#{@entry.place_id}", notice: "Entry created successfully!"
    else
      redirect_to "/entries/new", alert: "Failed to create entry."
    end
  end

  def show
    @entry = Entry.find_by(id: params[:id], user_id: session["user_id"])
    if @entry.nil?
      redirect_to entries_path, alert: "You are not authorized to view this entry."
    end
  end

  private

  def entry_params
    params.permit(:title, :description, :occurred_on, :place_id)
  end

  def require_login
    unless session["user_id"]
      redirect_to "/login", alert: "You must be logged in to access this section."
    end
  end
end
