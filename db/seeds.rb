# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def cadastrar_vacinas_do_calendario
  return if Vacina.all.any?

  # BCG
  bcg = Vacina.create!(descricao: "BCG", ordem_no_calendario: 0)
  bcg.dose_do_calendarios.create!(idade_recomendada: 0)

  # Hepatite B
  hepatite_b = Vacina.create!(descricao: "Hepatite B recombinante", ordem_no_calendario: 1)
  hepatite_b.dose_do_calendarios.create!(idade_recomendada: 0)

  # Poliomielite
  poliomielite = Vacina.create!(descricao: "Poliomielite 1,2,3 (VIP - inativada)",
                                ordem_no_calendario: 2, dias_de_intervalo: 30)

  poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.2)
  poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.4)
  poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.6)
end

ActiveRecord::Base.transaction do
  cadastrar_vacinas_do_calendario
end
