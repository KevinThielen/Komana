Komana::Application.routes.draw do
  devise_for :users

  get "welcome/index"
  
  
  root "welcome#index"
  get "welcome/dashboard"
  get "portfolios/contact"
  

  resources :portfolios
 
  resources :conversations do
		post :reply
		post :trash
		post :untrash
  end
    

  resources :lists do
		post "move_up"
		post "move_down"
  end
  resources :projects do
	post "add_user"
	resources :lists do
		resources :tasks
	end
	
	resources :tasks do
		get "move_up"
		get "move_down"
		get "move_to_next_list"
		get "move_to_prev_list"
	end
  end
end
