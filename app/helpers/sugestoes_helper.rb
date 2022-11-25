module SugestoesHelper
  def exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)
    return if recomendacao_vacina.status_vacinal != :aguardando

    "disponível em: #{recomendacao_vacina.quando_pode_tomar_proxima_dose}"
  end
end
