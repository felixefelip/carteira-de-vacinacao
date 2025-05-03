# typed: true

class SugestoesController < ApplicationController
  def index
    @recomendacao_vacinas = Current.caderneta!.recomendacao_vacinas.joins(:vacina).order(:ordem_no_calendario)
    render Views::Sugestoes::Index.new(@recomendacao_vacinas)
  end
end
