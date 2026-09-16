class CadernetaController < VacinacaoController
  def index
    @vacinas = caderneta_ativa.vacinas.distinct
  end

  def show
    @vacina = Vacina.find(params.expect(:id))
    @fabricante_vacinas = @vacina.fabricante_vacinas
      .joins(:doses)
      .where(doses: { caderneta_id: caderneta_ativa.id })
      .distinct
  end
end
