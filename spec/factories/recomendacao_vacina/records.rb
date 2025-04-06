FactoryBot.define do
  factory :recomendacao_vacina_record, class: 'RecomendacaoVacina::Record' do
    status_vacinal { :aguardando }
    vacina
    user
  end
end
