Rails.application.routes.draw do
  get 'oauths/vkontakte'

  root 'pages#index'

  get 'about' => 'pages#about'
  get 'profile' => 'profile#index', as: :user_profile
  get 'profile/edit', as: :user_profile_edit
  post 'profile/update'


  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }
end
