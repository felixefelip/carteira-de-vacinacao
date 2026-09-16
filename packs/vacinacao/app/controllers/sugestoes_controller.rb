class SugestoesController < VacinacaoController
  def index
    @recomendacao_vacinas = caderneta_ativa.recomendacao_vacinas.joins(:vacina).order(:ordem_no_calendario)
  end
end
