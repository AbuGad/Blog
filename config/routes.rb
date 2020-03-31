Rails.application.routes.draw do
  
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :articles do
    resources :comments
  end

  post 'articles/:id/like', to: 'likes#toggle' , as: :toggle_like
  
  get 'signup', to: 'users#new'
  resources :users , exxcept:[:new]

  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

 	put 'deactivate/:id', to: 'users#deactivate', as: :deactivate
 	put 'activate/:id', to: 'users#activate', as: :activate

  put 'private/:id', to: 'articles#private', as: :private
  put 'public/:id', to: 'articles#public', as: :public

end
