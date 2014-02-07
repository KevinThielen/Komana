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
    
  resources :tasks do
	post "search"
	post :update_position
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

	end
  end
end
