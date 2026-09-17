class ProfissionaisController < ApplicationController
  before_action :set_profissional, only: %i[edit update]
  before_action :carregar_especialidades, only: %i[new edit create update]

  def index
    @profissionais = Profissional.includes(:especialidade).order(:nome)
  end

  def new
    @profissional = Profissional.new
  end

  def edit; end

  def create
    @profissional = Profissional.new(profissional_params)

    if @profissional.save
      redirect_to profissionais_path, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @profissional.update(profissional_params)
      redirect_to profissionais_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_profissional
    @profissional = Profissional.find(params.expect(:id))
  end

  def carregar_especialidades
    @especialidades = Especialidade.order(:nome)
  end

  def profissional_params
    params.expect(profissional: %i[nome especialidade_id])
  end
end
