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
