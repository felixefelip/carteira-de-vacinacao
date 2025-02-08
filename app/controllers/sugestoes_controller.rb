# typed: true

class SugestoesController < ApplicationController
  def index
    @recomendacao_vacinas = current_user!.recomendacao&.recomendacao_vacinas&.joins(:vacina)&.order(:ordem_no_calendario)
  end
end
