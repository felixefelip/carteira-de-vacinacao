# == Schema Information
#
# Table name: consultas
#
#  id                 :bigint           not null, primary key
#  motivo             :string           not null
#  orientacoes        :text
#  realizada_em       :datetime         not null
#  resumo             :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  agendamento_id     :bigint
#  especialidade_id   :bigint
#  estabelecimento_id :bigint
#  pessoa_id          :bigint           not null
#  profissional_id    :bigint
#
class Consulta < ApplicationRecord
  include Anexavel

  belongs_to :pessoa
  belongs_to :agendamento, optional: true
  belongs_to :especialidade, optional: true
  belongs_to :profissional, optional: true
  belongs_to :estabelecimento, optional: true
  has_many :prescricoes, dependent: :destroy

  before_validation :usar_especialidade_do_profissional, if: :will_save_change_to_profissional_id?

  validates :motivo, :realizada_em, presence: true
  validates :agendamento_id, uniqueness: true, allow_nil: true
  validate :agendamento_precisa_ser_da_mesma_pessoa
  validate :especialidade_precisa_ser_do_profissional, if: :referencia_clinica_alterada?

  after_create :marcar_agendamento_como_realizado

  private

  def agendamento_precisa_ser_da_mesma_pessoa
    return if agendamento.blank? || pessoa.blank? || agendamento.pessoa_id == pessoa_id

    errors.add(:agendamento, 'precisa pertencer à mesma pessoa')
  end

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

  def marcar_agendamento_como_realizado
    agendamento&.realizado!
  end
end
