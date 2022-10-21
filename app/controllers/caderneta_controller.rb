class CadernetaController < ApplicationController
  before_action :set_vacina, only: %i[show]

  def index
    @vacinas = current_user.vacinas.uniq
  end

  def show
    @fabricante_vacinas = @vacina.fabricante_vacinas.joins(:doses).where("doses.user_id = ? ", current_user.id).uniq
  end

  def set_vacina
    @vacina = Vacina.find(params[:id])
  end
end
