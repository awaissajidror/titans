Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
  }

  resources :cash_ups do
    member do
      get :generate_pdf
    end

    collection do
      get :sp_report
      get :generate_sp_pdf
      post :process_report
    end
  end

  resources :users, except: [:create, :update]
  post '/create/employee', to: 'users#create'
  put '/update/employee',  to: 'users#update'

  get  '/attendances',      to: 'attendances#index'
  post '/mark_attendance',  to: 'attendances#mark_attendance'


end
