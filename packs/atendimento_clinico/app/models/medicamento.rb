# == Schema Information
#
# Table name: medicamentos
#
#  id              :bigint           not null, primary key
#  apresentacao     :string
#  nome             :string           not null
#  principio_ativo :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Medicamento < ApplicationRecord
  has_many :prescricoes, dependent: :restrict_with_exception

  validates :nome, presence: true

  def identificacao
    [nome, principio_ativo, apresentacao].compact_blank.join(' · ')
  end
end
