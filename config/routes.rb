Komana::Application.routes.draw do
  devise_for :users

  get "welcome/index"
  
  
  root "welcome#index"
  get "welcome/dashboard"
  get "portfolios/contact"
  

  resources :portfolios
 
  resources :conversations

  resources :lists do
		post "move_up"
  end
  resources :projects do
	post "add_user"
	resources :lists do
		resources :tasks
	end
	
	resources :tasks do
		get "move_to_next_list"
		get "move_to_prev_list"
	end
  end
end
