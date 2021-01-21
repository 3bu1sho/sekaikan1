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
    post 'sekais' => 'sekais#create'
    patch 'sekais/:id' => 'sekais#update', as: 'update_sekai'
  
  resources :sekais do
     resource :favorites, only: [:create, :destroy]
     resources :comments, only: [:create, :destroy]
  end
  
  resources :posts
  
#   resources :users do
#         resources :sekais

#   end#   resources :sekais
  
#  get 'user/sekais/new', to: 'user/sekais#new'

end