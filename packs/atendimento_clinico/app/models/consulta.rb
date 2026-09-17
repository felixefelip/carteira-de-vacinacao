# == Schema Information
#
# Table name: consultas
#
#  id                   :bigint           not null, primary key
#  especialidade        :string
#  estabelecimento_nome :string
#  motivo               :string           not null
#  orientacoes          :text
#  profissional_nome    :string
#  realizada_em         :datetime         not null
#  resumo               :text
#  agendamento_id       :bigint
#  pessoa_id            :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Consulta < ApplicationRecord
  include Anexavel

  belongs_to :pessoa
  belongs_to :agendamento, optional: true

  validates :motivo, :realizada_em, presence: true
  validates :agendamento_id, uniqueness: true, allow_nil: true
  validate :agendamento_precisa_ser_da_mesma_pessoa

  after_create :marcar_agendamento_como_realizado

  private

  def agendamento_precisa_ser_da_mesma_pessoa
    return if agendamento.blank? || pessoa.blank? || agendamento.pessoa_id == pessoa_id

    errors.add(:agendamento, 'precisa pertencer à mesma pessoa')
  end

  def marcar_agendamento_como_realizado
    agendamento&.realizado!
  end
end
