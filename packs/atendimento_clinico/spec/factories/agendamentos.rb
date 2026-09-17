FactoryBot.define do
  factory :agendamento do
    pessoa
    motivo { 'Consulta de rotina' }
    inicio_em { 1.week.from_now.change(sec: 0) }
    duracao_minutos { 60 }
    status { :agendado }
  end
end
