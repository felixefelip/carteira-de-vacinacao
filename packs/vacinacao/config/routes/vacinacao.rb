root 'caderneta#index'

resources :fabricante_vacinas

resources :vacinas do
  resources :doses, only: %i[new create edit update destroy show]
end

resources :caderneta, only: %i[index show]
resources :sugestoes, only: %i[index]
