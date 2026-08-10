FactoryBot.define do
  # Toda pessoa já nasce com uma caderneta, então aqui não se cria outra:
  # devolve-se a que a pessoa tem.
  factory :caderneta, class: 'Caderneta' do
    skip_create
    initialize_with { association(:pessoa).caderneta }
  end
end
