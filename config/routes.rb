Rails.application.routes.draw do

  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"

  get("/login", { controller: "sessions", action: "new" })
  post("/login", { controller: "sessions", action: "create" })
  get("/logout", { controller: "sessions", action: "destroy" })
  get("/signup", { controller: "users", action: "new" })

  resources :entries, only: [:index, :new, :create, :show]

  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"

  root "entries#index"
  
  get("/", { controller: "places", action: "index" })
end