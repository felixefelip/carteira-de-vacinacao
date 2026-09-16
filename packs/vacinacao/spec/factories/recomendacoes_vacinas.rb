FactoryBot.define do
  factory :recomendacao_vacina, class: 'Caderneta::RecomendacaoVacina' do
    status_vacinal { :aguardando }
    vacina
    caderneta
  end
end
