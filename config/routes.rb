Rails.application.routes.draw do
  get("/", { :controller => "misc", :action => "homepage" })
  get("/directors", { :controller => "misc", :action => "directors" })
  get("/directors/:id", { :controller => "misc", :action => "director"})
  get("/movies", { :controller => "misc", :action => "movies" })
  get("/movies/:id", { :controller => "misc", :action => "movie" })
  get("/actors", { :controller => "misc", :action => "actors" })
  get("/actors/:id", { :controller => "misc", :action => "actor" })
end
