# typed: true

class SugestoesController < ApplicationController
  def index
    @recomendacao_vacinas = Current.user!.recomendacao&.recomendacao_vacinas&.joins(:vacina)&.order(:ordem_no_calendario)
  end
end
