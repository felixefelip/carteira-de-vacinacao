class ConsultasController < ApplicationController
  before_action :set_consulta, only: %i[show edit update]
  before_action :carregar_cadastros_clinicos, only: %i[index new edit create update]

  def index
    @filtros = filtros_params
    @filtros_ativos = @filtros.to_h.values.any?(&:present?)
    @consultas = FiltroDeAtendimentos.new(
      consultas_da_pessoa, @filtros, coluna_data: :realizada_em
    ).resultado.order(realizada_em: :desc)
  end

  def show
    @prescricoes = @consulta.prescricoes.includes(:medicamento).order(inicio_em: :desc)
  end

  def new
    @consulta = consultas_da_pessoa.build
    preencher_com_agendamento if params[:agendamento_id].present?
  end

  def edit; end

  def create
    atributos = consulta_params
    agendamento_id = atributos.delete(:agendamento_id)
    @consulta = consultas_da_pessoa.build(atributos)
    @consulta.agendamento = agendamentos_da_pessoa.find(agendamento_id) if agendamento_id.present?

    if @consulta.save
      redirect_to @consulta, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @consulta.update(consulta_params.except(:agendamento_id))
      redirect_to @consulta, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_consulta
    @consulta = consultas_da_pessoa.find(params.expect(:id))
  end

  def consultas_da_pessoa
    Consulta.with_attached_anexos
      .includes(:agendamento, :especialidade, :profissional, :estabelecimento)
      .where(pessoa_id: Current.pessoa.id)
  end

  def agendamentos_da_pessoa
    Agendamento.where(pessoa_id: Current.pessoa.id)
  end

  def preencher_com_agendamento
    agendamento = agendamentos_da_pessoa.find(params.expect(:agendamento_id))
    return redirect_to agendamento.consulta if agendamento.consulta.present?

    @consulta.assign_attributes(atributos_do_agendamento(agendamento))
  end

  def atributos_do_agendamento(agendamento)
    {
      agendamento:,
      realizada_em: agendamento.inicio_em,
      motivo: agendamento.motivo,
      especialidade: agendamento.especialidade,
      profissional: agendamento.profissional,
      estabelecimento: agendamento.estabelecimento,
    }
  end

  def carregar_cadastros_clinicos
    @especialidades = Especialidade.order(:nome)
    @profissionais = Profissional.includes(:especialidade).order(:nome)
    @estabelecimentos = Estabelecimento.order(:nome)
  end

  def consulta_params
    params.expect(
      consulta: [
        :agendamento_id, :realizada_em, :motivo, :especialidade_id, :profissional_id,
        :estabelecimento_id, :resumo, :orientacoes, { anexos: [] }
      ],
    )
  end

  def filtros_params
    params.fetch(:filtro, ActionController::Parameters.new)
      .permit(:data_de, :data_ate, :profissional_id, :especialidade_id, :estabelecimento_id)
  end
end
