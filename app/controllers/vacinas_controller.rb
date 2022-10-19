class VacinasController < ApplicationController
  before_action :set_vacina, only: %i[show edit update destroy]

  def index
    @vacinas = Vacina.all
  end

  def show; end

  def new
    @vacina = Vacina.new
  end

  def edit; end

  def create
    @vacina = Vacina.new(vacina_params)

    if @vacina.save
      redirect_to vacina_url(@vacina), notice: 'Vacina was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @vacina.update(vacina_params)
      redirect_to vacina_url(@vacina), notice: 'Vacina was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vacina.destroy

    redirect_to vacinas_url, notice: 'Vacina was successfully destroyed.'
  end

  private

  def set_vacina
    @vacina = Vacina.find(params[:id])
  end

  def vacina_params
    params.require(:vacina).permit(:descricao)
  end
end
