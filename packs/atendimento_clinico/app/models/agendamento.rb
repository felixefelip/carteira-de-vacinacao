# == Schema Information
#
# Table name: agendamentos
#
#  id                   :bigint           not null, primary key
#  duracao_minutos      :integer
#  especialidade        :string
#  estabelecimento_nome :string
#  inicio_em            :datetime         not null
#  motivo               :string           not null
#  observacoes          :text
#  pago_em              :date
#  profissional_nome    :string
#  status               :string           default("agendado"), not null
#  valor                :decimal(10, 2)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  pessoa_id            :bigint           not null
#
class Agendamento < ApplicationRecord
  include Anexavel

  belongs_to :pessoa

  enum :status, {
    agendado: 'agendado',
    realizado: 'realizado',
    cancelado: 'cancelado',
  }, default: :agendado, validate: true

  validates :motivo, :inicio_em, presence: true
  validates :duracao_minutos, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :valor, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def pago?
    pago_em.present?
  end
end
