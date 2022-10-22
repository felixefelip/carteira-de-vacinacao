class DosesController < ApplicationController
  before_action :set_dose, only: %i[show edit update]
  before_action :set_vacina, only: %i[new create edit update]

  def index
    @doses = current_user.doses.all
  end

  def show; end

  def new
    @dose = Dose.new
  end

  def edit; end

  def create
    @dose = current_user.doses.new(dose_params)

    if @dose.save
      redirect_to caderneta_url, notice: 'Dose cadastrada com sucesso.'
    else
      render :new, status: :unprocessable_entity
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
