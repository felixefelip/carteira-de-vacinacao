class CadernetaController < ApplicationController
  def index
    @vacinas = Current.caderneta.vacinas.distinct
  end

  def show
    @vacina = Vacina.find(params[:id])
    @fabricante_vacinas = @vacina.fabricante_vacinas.joins(:doses).where('doses.caderneta_id = ?', Current.caderneta.id).distinct
  end
end
