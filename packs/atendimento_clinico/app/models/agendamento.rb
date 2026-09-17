# == Schema Information
#
# Table name: agendamentos
#
#  id                 :bigint           not null, primary key
#  duracao_minutos    :integer
#  inicio_em          :datetime         not null
#  motivo             :string           not null
#  observacoes        :text
#  pago_em            :date
#  status             :string           default("agendado"), not null
#  valor              :decimal(10, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  especialidade_id   :bigint
#  estabelecimento_id :bigint
#  pessoa_id          :bigint           not null
#  profissional_id    :bigint
#
class Agendamento < ApplicationRecord
  include Anexavel

  belongs_to :pessoa
  belongs_to :especialidade, optional: true
  belongs_to :profissional, optional: true
  belongs_to :estabelecimento, optional: true
  has_one :consulta, dependent: :nullify

  enum :status, {
    agendado: 'agendado',
    realizado: 'realizado',
    cancelado: 'cancelado',
  }, default: :agendado, validate: true

  before_validation :usar_especialidade_do_profissional, if: :will_save_change_to_profissional_id?

  validates :motivo, :inicio_em, presence: true
  validates :duracao_minutos, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :valor, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :especialidade_precisa_ser_do_profissional, if: :referencia_clinica_alterada?

  def pago?
    pago_em.present?
  end

  private

  def referencia_clinica_alterada?
    new_record? || will_save_change_to_profissional_id? || will_save_change_to_especialidade_id?
  end

  def especialidade_precisa_ser_do_profissional
    return if profissional.blank? || profissional.especialidade.blank?
    return if especialidade == profissional.especialidade

    errors.add(:especialidade, 'precisa ser a especialidade do profissional')
  end

  def usar_especialidade_do_profissional
    self.especialidade = profissional.especialidade if profissional&.especialidade
  end
end
