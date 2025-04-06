# typed: true

class DosesController < ApplicationController
  before_action :set_dose, only: %i[show edit]
  before_action :set_vacina, only: %i[new create edit]

  def index
    @doses = current_user!.doses.all
    render Views::Doses::Index.new(doses: vacina_path)
  end

  def show; end

  def new
    @dose = Dose::Record.new
    render Views::Doses::New.new(dose: @dose, vacina: @vacina)
  end

  def edit; end

  def create
    @dose = current_user!.doses.new(dose_params)

    if @dose.save
      redirect_to caderneta_url, notice: 'Dose cadastrada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_dose
    @dose = Dose::Record.find(params[:id])
    @dose.vacina
  end

  def set_vacina
    @vacina = Vacina::Record.find(params[:vacina_id])
  end

  def dose_params
    params.require(:dose_record).permit(:data_vacinacao, :lote_numero, :vacinador_codigo, :local_codigo, :fabricante_vacina_id)
  end
end
