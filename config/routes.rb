Rails.application.routes.draw do
  devise_for :users
  get 'accounts/inactive' => 'accounts#inactive'
  
  resources :accounts do
    resources :transactions
    resources :documents

    member do
      get :deactivate
      get :activate
    end
  end

  authenticated do
    root to: 'accounts#index'
  end

  root to: 'static_pages#home'
end
