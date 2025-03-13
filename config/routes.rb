Rails.application.routes.draw do

  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"

  get("/login", { controller: "sessions", action: "new" })
  get("/login", {:controller => "sessions", :action => "new"})
  get("/logout", {:controller => "sessions", :action => "destroy"})
  get("/signup", { controller: "users", action: "new" })
  
  root to: 'places#index'
  #get("/", { controller: "places", action: "index" })
end