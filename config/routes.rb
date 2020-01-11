Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'

  resources :projects, only: [:index, :show] do
    resources :issues, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'reopen'
        put 'close'
      end
    end
  end

  resources :comments, only: [:create]
end
