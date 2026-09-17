FactoryBot.define do
  factory :consulta do
    pessoa
    motivo { 'Consulta de rotina' }
    realizada_em { Time.zone.local(2026, 9, 20, 14, 30) }
  end
end
