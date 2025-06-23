# typed: true

class DosesController < ApplicationController
  before_action :set_dose, only: %i[show edit]
  before_action :set_vacina, only: %i[new create edit]

  def show; end

  def new
    @dose = Dose.new
    render Views::Doses::New.new(dose: @dose, vacina: @vacina)
  end

  def edit; end

  def create
    @dose = Dose.new(dose_params)
    @dose.caderneta = Current.caderneta!

    if @dose.save
      redirect_to caderneta_url, notice: 'Dose cadastrada com sucesso.'
    else
      render Views::Doses::New.new(dose: @dose, vacina: @vacina), status: :unprocessable_entity
    end
  end

  private

  def set_dose
    @dose = Dose.find(params[:id])
  end

  def set_vacina
    @vacina = Vacina.find(params[:vacina_id])
  end

  def dose_params
    params.require(:dose).permit(:data_vacinacao, :lote_numero, :vacinador_codigo, :local_codigo, :fabricante_vacina_id)
  end
end
