Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects, only: [:index, :show, :new] do
    resources :issues, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'close'
      end
    end
  end

end
