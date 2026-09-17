# == Schema Information
#
# Table name: prescricoes
#
#  id                 :bigint           not null, primary key
#  inicio_em          :date             not null
#  orientacoes        :text
#  posologia          :string           not null
#  termino_em         :date
#  via_administracao  :string
#  consulta_id        :bigint           not null
#  medicamento_id     :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Prescricao < ApplicationRecord
  belongs_to :consulta
  belongs_to :medicamento

  validates :posologia, :inicio_em, presence: true
  validate :termino_nao_pode_anteceder_inicio

  scope :da_pessoa, ->(pessoa) { joins(:consulta).where(consultas: { pessoa_id: pessoa.id }) }

  def situacao_em(data)
    return :planejada if inicio_em > data
    return :encerrada if termino_em.present? && termino_em < data

    :em_uso
  end

  private

  def termino_nao_pode_anteceder_inicio
    return if inicio_em.blank? || termino_em.blank? || termino_em >= inicio_em

    errors.add(:termino_em, 'não pode ser anterior ao início do tratamento')
  end
end
