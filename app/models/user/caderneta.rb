# typed: true

# == Schema Information
#
# Table name: cadernetas
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#

class User::Caderneta < ApplicationRecord
  extend T::Sig

  self.table_name = 'cadernetas'

  belongs_to :user
  has_many :doses, dependent: :destroy, inverse_of: :caderneta
  has_many :fabricante_vacinas, through: :doses
  has_many :vacinas, through: :fabricante_vacinas
  has_many :recomendacao_vacinas, dependent: :destroy, inverse_of: :caderneta

  after_create :criar_caderneta_de_vacinacao
  after_update :atualizar_caderneta_de_vacinacao

  sig { void }
  def criar_caderneta_de_vacinacao
    Cadastrar.new(self).call
  end

  sig { void }
  def atualizar_caderneta_de_vacinacao
    Atualizar.new(self).call
  end

  sig { params(fabricante_vacina: FabricanteVacina).returns(Integer) }
  def qtde_por_fabricante_vacina(fabricante_vacina)
    fabricante_vacinas.where(id: fabricante_vacina.id).count
  end

  sig { params(vacina: Vacina).returns(Integer) }
  def qtde_por_vacina(vacina)
    fabricante_vacinas.where(vacina:).count
  end
end
