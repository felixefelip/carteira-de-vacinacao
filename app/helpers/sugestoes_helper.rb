# typed: true

module SugestoesHelper
  extend T::Sig

  sig { params(recomendacao_vacina: RecomendacaoVacina::Record).returns(String) }
  def exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)
    return '' if recomendacao_vacina.status_vacinal != 'aguardando'

    " - disponível em: #{recomendacao_vacina.quando_pode_tomar_proxima_dose&.strftime('%d/%m/%Y')}"
  end
end
