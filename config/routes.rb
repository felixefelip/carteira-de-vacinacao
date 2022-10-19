Rails.application.routes.draw do
  root 'vacinas#index'

  devise_for :users

  resources :vacinas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
