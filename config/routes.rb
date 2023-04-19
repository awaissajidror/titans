Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  resources :cash_ups do
    member do
      get :generate_pdf
    end
  end

end
