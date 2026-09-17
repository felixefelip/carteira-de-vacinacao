FactoryBot.define do
  factory :prescricao do
    consulta
    medicamento
    posologia { '1 comprimido pela manhã' }
    inicio_em { Date.current }
  end
end
