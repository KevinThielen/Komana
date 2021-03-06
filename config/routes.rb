Komana::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :projects
  get "welcome/index"
  
  
  root "welcome#index"
  get "welcome/dashboard"
  get "portfolios/contact"
  

  resources :portfolios
 
  resources :conversations do
	post :reply
	post :trash
	post :untrash
    post :mark_as_unread
    post :mark_as_read
    delete :delete
  end
  
  #needed for the dashboard overview
  resources :tasks do
    collection do
	    get "search"
    end
	post :update_position
  end
  
  resources :lists do
		post "move_up"
		post "move_down"
  end
  

  resources :projects do
		post "add_user"
		post "remove_user"
	resources :lists do
		resources :tasks
	end
  end
end
