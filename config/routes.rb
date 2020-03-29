Rails.application.routes.draw do
  
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :articles

  post 'articles/:id/like', to: 'likes#create' , as: :like_article
  post 'articles/:id/unlike', to: 'likes#destroy', as: :unlike_article
  
  get 'signup', to: 'users#new'
  resources :users , exxcept:[:new]

  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

 	put 'deactivate/:id', to: 'users#deactivate', as: :deactivate
 	put 'activate/:id', to: 'users#activate', as: :activate

end
