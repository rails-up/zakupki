Rails.application.routes.draw do
  get 'oauths/vkontakte'

  root 'pages#index'

  get 'about' => 'pages#about'

  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }
end
