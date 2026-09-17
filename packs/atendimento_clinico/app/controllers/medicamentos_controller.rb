class MedicamentosController < ApplicationController
  before_action :set_medicamento, only: %i[edit update]
  before_action :set_consulta_para_retorno, only: %i[new create]

  def index
    @medicamentos = Medicamento.order(:nome, :apresentacao)
  end

  def new
    @medicamento = Medicamento.new
  end

  def edit; end

  def create
    @medicamento = Medicamento.new(medicamento_params)

    if @medicamento.save
      redirect_to destino_apos_cadastro, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @medicamento.update(medicamento_params)
      redirect_to medicamentos_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_medicamento
    @medicamento = Medicamento.find(params.expect(:id))
  end

  def medicamento_params
    params.expect(medicamento: %i[nome principio_ativo apresentacao])
  end

  def set_consulta_para_retorno
    return if params[:consulta_id].blank?

    @consulta = Consulta.where(pessoa_id: Current.pessoa.id).find(params.expect(:consulta_id))
  end

  def destino_apos_cadastro
    return medicamentos_path if @consulta.blank?

    new_consulta_prescricao_path(@consulta)
  end
end
