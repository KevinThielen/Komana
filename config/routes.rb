Komana::Application.routes.draw do
  devise_for :users
  get "welcome/index"
  
  
  root "welcome#index"
  get "welcome/dashboard"
  get "welcome/contact"
  

  resources :portfolios
  resources :conversations
  
  resources :projects do
	resources :lists
	resources :tasks do
		get "move_to_next_list"
		get "move_to_prev_list"
	end
  end
end
