class PrescricoesController < ApplicationController
  before_action :set_consulta, except: :index
  before_action :set_prescricao, only: %i[edit update]

  def index
    @prescricoes = Prescricao.da_pessoa(Current.pessoa)
      .includes(:medicamento, :consulta)
      .order(inicio_em: :desc, created_at: :desc)
  end

  def new
    @prescricao = @consulta.prescricoes.build(inicio_em: Date.current)
    carregar_medicamentos
  end

  def edit
    carregar_medicamentos
  end

  def create
    @prescricao = @consulta.prescricoes.build(prescricao_params)

    if @prescricao.save
      redirect_to @consulta, notice: t('.success')
    else
      carregar_medicamentos
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @prescricao.update(prescricao_params)
      redirect_to @consulta, notice: t('.success')
    else
      carregar_medicamentos
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_consulta
    @consulta = Consulta.where(pessoa_id: Current.pessoa.id).find(params.expect(:consulta_id))
  end

  def set_prescricao
    @prescricao = @consulta.prescricoes.find(params.expect(:id))
  end

  def carregar_medicamentos
    @medicamentos = Medicamento.order(:nome, :apresentacao)
  end

  def prescricao_params
    params.expect(
      prescricao: %i[
        medicamento_id posologia via_administracao inicio_em termino_em orientacoes
      ],
    )
  end
end
