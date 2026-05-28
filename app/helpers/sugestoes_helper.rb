# typed: true

module SugestoesHelper
  extend T::Sig

  sig { params(recomendacao_vacina: User::Caderneta::RecomendacaoVacina).returns(T.nilable(String)) }
  def idade_recomendada_para(recomendacao_vacina)
    dose_atual = recomendacao_vacina.dose_recomendada_atual
    return nil unless dose_atual

    dose_calendario = DoseDoCalendario.find_by(vacina: recomendacao_vacina.vacina)
    return nil unless dose_calendario&.idade_recomendada

    idade_meses = dose_calendario.idade_recomendada.to_i

    if idade_meses == 0
      "Ao nascer"
    elsif idade_meses < 12
      "#{idade_meses} #{idade_meses == 1 ? 'mês' : 'meses'}"
    else
      anos = idade_meses / 12
      meses_restantes = idade_meses % 12

      if meses_restantes == 0
        "#{anos} #{anos == 1 ? 'ano' : 'anos'}"
      else
        "#{anos}a #{meses_restantes}m"
      end
    end
  end
end
