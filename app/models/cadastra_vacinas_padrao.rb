# typed: true

class CadastraVacinasPadrao
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

    # Pentavalente (DTP + Hib + Hepatite B)
    pentavalente = Vacina.create!(descricao: 'Pentavalente (DTP + Hib + Hepatite B)',
                                  ordem_no_calendario: 3, dias_de_intervalo: 30)

    pentavalente.dose_do_calendarios.create!(idade_recomendada: 0.2)
    pentavalente.dose_do_calendarios.create!(idade_recomendada: 0.4)
    pentavalente.dose_do_calendarios.create!(idade_recomendada: 0.6)

    # Pneumocócica 10-valente
    pneumococica = Vacina.create!(descricao: 'Pneumocócica 10-valente (conjugada)',
                                  ordem_no_calendario: 4, dias_de_intervalo: 30)

    pneumococica.dose_do_calendarios.create!(idade_recomendada: 0.2)
    pneumococica.dose_do_calendarios.create!(idade_recomendada: 0.4)
    pneumococica.dose_do_calendarios.create!(idade_recomendada: 1.0)

    # Rotavírus
    rotavirus = Vacina.create!(descricao: 'Rotavírus humano G1P1 (atenuada)',
                               ordem_no_calendario: 5, dias_de_intervalo: 30)

    rotavirus.dose_do_calendarios.create!(idade_recomendada: 0.2)
    rotavirus.dose_do_calendarios.create!(idade_recomendada: 0.4)

    # Meningocócica C
    meningococica_c = Vacina.create!(descricao: 'Meningocócica C (conjugada)',
                                     ordem_no_calendario: 6, dias_de_intervalo: 30)

    meningococica_c.dose_do_calendarios.create!(idade_recomendada: 0.3)
    meningococica_c.dose_do_calendarios.create!(idade_recomendada: 0.5)
    meningococica_c.dose_do_calendarios.create!(idade_recomendada: 1.0)

    # Febre Amarela
    febre_amarela = Vacina.create!(descricao: 'Febre amarela (atenuada)',
                                   ordem_no_calendario: 7)

    febre_amarela.dose_do_calendarios.create!(idade_recomendada: 0.75)

    # Tríplice viral (Sarampo, Caxumba, Rubéola)
    triplice_viral = Vacina.create!(descricao: 'Tríplice viral (Sarampo, Caxumba, Rubéola)',
                                    ordem_no_calendario: 8, dias_de_intervalo: 30)

    triplice_viral.dose_do_calendarios.create!(idade_recomendada: 1.0)
    triplice_viral.dose_do_calendarios.create!(idade_recomendada: 1.25)

    # DTP (Tríplice bacteriana)
    dtp = Vacina.create!(descricao: 'DTP (Difteria, Tétano, Pertussis)',
                         ordem_no_calendario: 9, dias_de_intervalo: 30)

    dtp.dose_do_calendarios.create!(idade_recomendada: 1.25)

    # Hepatite A
    hepatite_a = Vacina.create!(descricao: 'Hepatite A',
                                ordem_no_calendario: 10)

    hepatite_a.dose_do_calendarios.create!(idade_recomendada: 1.25)

    # Varicela (Catapora)
    varicela = Vacina.create!(descricao: 'Varicela (Catapora)',
                              ordem_no_calendario: 11)

    varicela.dose_do_calendarios.create!(idade_recomendada: 1.25)

    # Meningocócica ACWY
    meningococica_acwy = Vacina.create!(descricao: 'Meningocócica ACWY (conjugada)',
                                        ordem_no_calendario: 12, dias_de_intervalo: 150)

    meningococica_acwy.dose_do_calendarios.create!(idade_recomendada: 11.0)
    meningococica_acwy.dose_do_calendarios.create!(idade_recomendada: 12.0)

    # HPV
    hpv = Vacina.create!(descricao: 'HPV quadrivalente',
                         ordem_no_calendario: 13, dias_de_intervalo: 180)

    hpv.dose_do_calendarios.create!(idade_recomendada: 11.0)
    hpv.dose_do_calendarios.create!(idade_recomendada: 11.5)

    # dT (Dupla adulto)
    dt_adulto = Vacina.create!(descricao: 'dT (Dupla adulto - Difteria e Tétano)',
                               ordem_no_calendario: 14, dias_de_intervalo: 3650) # 10 anos

    dt_adulto.dose_do_calendarios.create!(idade_recomendada: 15.0)

    # COVID-19
    covid19 = Vacina.create!(descricao: 'COVID-19',
                             ordem_no_calendario: 15, dias_de_intervalo: 21)

    covid19.dose_do_calendarios.create!(idade_recomendada: 0.5)
    covid19.dose_do_calendarios.create!(idade_recomendada: 0.6)

    # Influenza (Gripe)
    influenza = Vacina.create!(descricao: 'Influenza (Gripe)',
                               ordem_no_calendario: 16, dias_de_intervalo: 365) # Anual

    influenza.dose_do_calendarios.create!(idade_recomendada: 0.5)
  end
end
