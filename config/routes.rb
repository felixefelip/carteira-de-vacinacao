Rails.application.routes.draw do
  root 'caderneta#index'

  devise_for :users

  resources :fabricante_vacinas

  resources :vacinas do
    resources :doses
  end

  resources :caderneta, only: %i[index show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
