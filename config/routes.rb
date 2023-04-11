Rails.application.routes.draw do
  resources :cash_ups
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  root 'homes#index'
end
