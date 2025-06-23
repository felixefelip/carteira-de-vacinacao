Rails.application.routes.draw do
  root 'caderneta#index'

  devise_for :users, class_name: "User", controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :fabricante_vacinas

  resources :vacinas do
    resources :doses, only: %i[new create edit update destroy show]
  end

  resources :caderneta, only: %i[index show]
  resources :sugestoes, only: %i[index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
