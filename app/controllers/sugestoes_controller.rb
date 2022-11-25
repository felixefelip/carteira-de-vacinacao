class SugestoesController < ApplicationController
  before_action :set_vacina, only: %i[show edit update destroy]

  def index
    @recomendacao_vacinas = current_user.recomendacao.recomendacao_vacinas
  end

  private

  def set_vacina
    @vacina = Vacina.find(params[:id])
  end
end
