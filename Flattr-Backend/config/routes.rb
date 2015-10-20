Rails.application.routes.draw do
  post 'facebook' => 'users#facebook'
  post 'google' => 'users#google'
  get 'user_photos' => 'photos#user_photos'

  resources :users
  resources :photos
  resources :votes

  resources :users do
    resources :photos
  end

end
