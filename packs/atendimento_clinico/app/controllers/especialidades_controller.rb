class EspecialidadesController < ApplicationController
  before_action :set_especialidade, only: %i[edit update]

  def index
    @especialidades = Especialidade.order(:nome)
  end

  def new
    @especialidade = Especialidade.new
  end

  def edit; end

  def create
    @especialidade = Especialidade.new(especialidade_params)

    if @especialidade.save
      redirect_to especialidades_path, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @especialidade.update(especialidade_params)
      redirect_to especialidades_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_especialidade
    @especialidade = Especialidade.find(params.expect(:id))
  end

  def especialidade_params
    params.expect(especialidade: [:nome])
  end
end
