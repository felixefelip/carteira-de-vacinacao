resources :agendamentos, except: %i[show destroy]
resources :consultas, except: :destroy do
  resources :prescricoes, except: %i[index show destroy]
end
resources :prescricoes, only: :index
resources :medicamentos, except: %i[show destroy]
