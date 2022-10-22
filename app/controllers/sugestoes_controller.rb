class SugestoesController < ApplicationController
  before_action :set_vacina, only: %i[show edit update destroy]

  def index
    @vacinas = Vacina.all.order(updated_at: :desc)
  end

  private

  def set_vacina
    @vacina = Vacina.find(params[:id])
  end
end
