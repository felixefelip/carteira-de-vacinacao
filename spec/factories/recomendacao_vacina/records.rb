FactoryBot.define do
  factory :recomendacao_vacina_record, class: 'RecomendacaoVacina' do
    status_vacinal { :aguardando }
    vacina
    user
  end
end
