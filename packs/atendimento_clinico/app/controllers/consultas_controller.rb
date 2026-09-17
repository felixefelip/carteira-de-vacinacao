class ConsultasController < ApplicationController
  before_action :set_consulta, only: %i[edit update]

  def index
    @consultas = consultas_da_pessoa.order(realizada_em: :desc)
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
      redirect_to consultas_path, notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @consulta.update(consulta_params.except(:agendamento_id))
      redirect_to consultas_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_consulta
    @consulta = consultas_da_pessoa.find(params.expect(:id))
  end

  def consultas_da_pessoa
    Consulta.with_attached_anexos.includes(:agendamento).where(pessoa_id: Current.pessoa.id)
  end

  def agendamentos_da_pessoa
    Agendamento.where(pessoa_id: Current.pessoa.id)
  end

  def preencher_com_agendamento
    agendamento = agendamentos_da_pessoa.find(params.expect(:agendamento_id))
    return redirect_to edit_consulta_path(agendamento.consulta) if agendamento.consulta.present?

    @consulta.assign_attributes(atributos_do_agendamento(agendamento))
  end

  def atributos_do_agendamento(agendamento)
    {
      agendamento:,
      realizada_em: agendamento.inicio_em,
      motivo: agendamento.motivo,
      especialidade: agendamento.especialidade,
      profissional_nome: agendamento.profissional_nome,
      estabelecimento_nome: agendamento.estabelecimento_nome,
    }
  end

  def consulta_params
    params.expect(
      consulta: [
        :agendamento_id, :realizada_em, :motivo, :especialidade, :profissional_nome,
        :estabelecimento_nome, :resumo, :orientacoes, { anexos: [] }
      ],
    )
  end
end
