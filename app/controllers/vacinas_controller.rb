# typed: true
class VacinasController < ApplicationController
  before_action :set_vacina, only: %i[show edit update destroy]

  def index
    @vacinas = Vacina::Record.all
  end

  def show; end

  def new
    @vacina = Vacina::Record.new
  end

  def edit; end

  def create
    @vacina = Vacina::Record.new(vacina_params)
    @vacina.fabricante_vacinas.new(descricao: @vacina.descricao)

    if @vacina.save
      redirect_to vacinas_path, notice: "Vacina foi criada com sucesso"
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
    @vacina = Vacina::Record.find(params[:id])
  end

  def vacina_params
    params.require(:vacina).permit(:descricao)
  end
end
