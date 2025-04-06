# typed: true

class Vacina::CadastraVacinasPadrao
  extend T::Sig

  sig { void }
  def self.call
    return if Vacina.all.any?

    # BCG
    bcg = Vacina.create!(descricao: 'BCG', ordem_no_calendario: 0)
    bcg.dose_do_calendarios.create!(idade_recomendada: 0)

    # Hepatite B
    hepatite_b = Vacina.create!(descricao: 'Hepatite B recombinante', ordem_no_calendario: 1)
    hepatite_b.dose_do_calendarios.create!(idade_recomendada: 0)

    # Poliomielite
    poliomielite = Vacina.create!(descricao: 'Poliomielite 1,2,3 (VIP - inativada)',
                                          ordem_no_calendario: 2, dias_de_intervalo: 30)

    poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.2)
    poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.4)
    poliomielite.dose_do_calendarios.create!(idade_recomendada: 0.6)
  end
end
