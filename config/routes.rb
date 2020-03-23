Rails.application.routes.draw do
  
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :articles
  get 'signup', to: 'users#new'
  resources :users , exxcept:[:new]

  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #post "deactivate", to: "users#deactivate"

 	put 'deactivate/:id', to: 'users#deactivate', as: :deactivate
 	put 'activate/:id', to: 'users#activate', as: :activate

end
