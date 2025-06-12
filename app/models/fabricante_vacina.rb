# typed: true

# == Schema Information
#
# Table name: fabricante_vacinas
#
#  id           :bigint           not null, primary key
#  descricao    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  caderneta_id :bigint           not null
#  vacina_id    :bigint           not null
#
class FabricanteVacina < ApplicationRecord
  self.table_name = 'fabricante_vacinas'

  extend T::Sig

  belongs_to :caderneta, optional: true, class_name: 'User::Caderneta'
  belongs_to :vacina

  has_many :doses, dependent: :nullify

  sig { returns(User::Caderneta) }
  def teste
    caderneta
  end

  sig { returns(User::Caderneta) }
  def caderneta
    super || User::CadernetaNil.new
  end
end
