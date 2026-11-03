class AgendamentosController < ApplicationController
  before_action :set_agendamento, only: %i[edit update]
  before_action :carregar_cadastros_clinicos, only: %i[index new edit create update]

  def index
    @filtros = filtros_params
    @filtros_ativos = @filtros.to_h.values.any?(&:present?)
    @agendamentos = FiltroDeAtendimentos.new(
      agendamentos_da_pessoa, @filtros, coluna_data: :inicio_em
    ).resultado.order(inicio_em: :asc)
  end

  def new
    @agendamento = agendamentos_da_pessoa.build
  end

  def edit; end

  def create
    @agendamento = agendamentos_da_pessoa.build(agendamento_params)

    if @agendamento.save
      redirect_to agendamentos_path, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @agendamento.update(agendamento_params)
      redirect_to agendamentos_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_agendamento
    @agendamento = agendamentos_da_pessoa.find(params.expect(:id))
  end

  def agendamentos_da_pessoa
    Agendamento.with_attached_anexos
      .includes(:consulta, :especialidade, :profissional, :estabelecimento)
      .where(pessoa_id: Current.pessoa.id)
  end

  def carregar_cadastros_clinicos
    @especialidades = Especialidade.order(:nome)
    @profissionais = Profissional.includes(:especialidade).order(:nome)
    @estabelecimentos = Estabelecimento.order(:nome)
  end

  def agendamento_params
    params.expect(
      agendamento: [
        :inicio_em, :duracao_minutos, :motivo, :especialidade_id, :profissional_id,
        :estabelecimento_id, :observacoes, :status, :valor, :pago_em,
        { anexos: [] }
      ],
    )
  end

  def filtros_params
    params.fetch(:filtro, ActionController::Parameters.new)
      .permit(:data_de, :data_ate, :profissional_id, :especialidade_id,
              :estabelecimento_id, :status, :pagamento)
  end
end
