Rails.application.routes.draw do

  get 'comments/create'
  get 'comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
devise_for :users, controllers: 
      {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
      }

devise_for :admins, controllers: 
      {
        sessions: 'admins/sessions'
      }
      
      
  root 'homes#top'
    get 'top' => 'homes#top'
    get 'sekais/mysekai' => 'sekais#mysekai'
    post 'sekais' => 'sekais#create'
    patch 'sekais/:id' => 'sekais#update'
  
  resources :sekais do
     resource :favorites, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy]
     resources :tags

  end
  
    get 'favorite_rank' => 'sekais#favorite_rank'
    
    
  resources :tags do
    get 'sekais', to: 'sekais#search'
  end
  
    get '/search', to: 'search#search'

  
#   resources :users do
#         resources :sekais

#   end#   resources :sekais
  
#  get 'user/sekais/new', to: 'user/sekais#new'

end