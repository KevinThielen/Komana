Komana::Application.routes.draw do
  get "welcome/index"
  
  #collection of projects
  resources :projects
  root "welcome#index"
end
