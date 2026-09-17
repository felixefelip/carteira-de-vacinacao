# == Schema Information
#
# Table name: profissionais
#
#  id                :bigint           not null, primary key
#  nome              :string           not null
#  especialidade_id  :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Profissional < ApplicationRecord
  belongs_to :especialidade, optional: true
  has_many :agendamentos, dependent: :restrict_with_exception
  has_many :consultas, dependent: :restrict_with_exception

  validates :nome, presence: true, uniqueness: { scope: :especialidade_id }

  def identificacao
    [nome, especialidade&.nome].compact_blank.join(' · ')
  end
end
