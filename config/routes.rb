Komana::Application.routes.draw do
  get "welcome/index"
  
  
  #collection of projects
  resources :projects
  root "welcome#index"
  

  
  
  resources :projects do
	resources :lists
	resources :tasks
  end
  
  
  resources :lists do
	resources :tasks
  end
  
  
end
