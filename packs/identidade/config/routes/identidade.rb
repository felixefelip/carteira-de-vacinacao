devise_for :users, class_name: 'User', controllers: { registrations: 'users/registrations' }

devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end

resources :pessoas, except: %i[show]

resource :perfil_ativo, only: %i[update], controller: 'perfil_ativo'
