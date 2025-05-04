FactoryBot.define do
  factory :recomendacao_vacina_record, class: 'User::Caderneta::RecomendacaoVacina' do
    status_vacinal { :aguardando }
    vacina
    caderneta
  end
end
