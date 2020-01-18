Rails.application.routes.draw do
  get 'signed-out', to: 'signouts#index'
  devise_for :users, except: :create, path: '', path_names: { sign_in: 'login', sign_out: 'signed-out' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :activities

  namespace :dashboard do
    resources :mains
    root to: "mains#index" 
    resources :users do
      collection do
        patch 'update_password'
        patch 'update_profile'
        # patch 'update_profile_image'
        patch 'create_user'
      end
    end
  end

  root to: 'activities#index'
end
