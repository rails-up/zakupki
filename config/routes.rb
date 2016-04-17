Rails.application.routes.draw do
  get 'oauths/vkontakte'

  root 'pages#index'

  get 'about' => 'pages#about'
  get 'profile' => 'profile#index', as: :user_profile
  get 'profile/edit', as: :user_profile_edit
  post 'profile/update'
  post 'profile/update_password'


  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }

  resources :users, :purchases, :groups, :comments
end
