class FiltroDeAtendimentos
  REFERENCIAS = %i[profissional_id especialidade_id estabelecimento_id].freeze

  def initialize(relacao, filtros, coluna_data:)
    @relacao = relacao
    @filtros = filtros
    @coluna_data = coluna_data
  end

  def resultado
    filtrar_periodo
    filtrar_referencias
    filtrar_status
    filtrar_pagamento
    relacao
  end

  private

  attr_accessor :relacao
  attr_reader :filtros, :coluna_data

  def filtrar_periodo
    self.relacao = relacao.where(coluna_data => data_de.beginning_of_day..) if data_de
    self.relacao = relacao.where(coluna_data => ..data_ate.end_of_day) if data_ate
  end

  def filtrar_referencias
    REFERENCIAS.each do |referencia|
      self.relacao = relacao.where(referencia => filtros[referencia]) if filtros[referencia].present?
    end
  end

  def filtrar_status
    return unless filtros[:status].present? && relacao.klass.statuses.key?(filtros[:status])

    self.relacao = relacao.where(status: filtros[:status])
  end

  def filtrar_pagamento
    self.relacao = relacao.where.not(pago_em: nil) if filtros[:pagamento] == 'pago'
    self.relacao = relacao.where(pago_em: nil) if filtros[:pagamento] == 'pendente'
  end

  def data_de
    @data_de ||= converter_data(:data_de)
  end

  def data_ate
    @data_ate ||= converter_data(:data_ate)
  end

  def converter_data(chave)
    Date.iso8601(filtros[chave]) if filtros[chave].present?
  rescue Date::Error
    nil
  end
end
