# typed: true

# == Schema Information
#
# Table name: vacinas
#
#  id                  :bigint           not null, primary key
#  descricao           :string
#  dias_de_intervalo   :integer          default(0), not null
#  ordem_no_calendario :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Vacina < ApplicationRecord
  extend T::Sig

  has_many :fabricante_vacinas, dependent: :destroy
  has_many :doses, through: :fabricante_vacinas
  has_many :recomendacao_vacinas, dependent: :destroy,
                                  class_name: 'User::Caderneta::RecomendacaoVacina'
  has_many :dose_do_calendarios, dependent: :destroy

  accepts_nested_attributes_for :fabricante_vacinas

  after_create :cadastrar_fornecedor_vacina_padrao, if: :sem_fabricante_vacina?

  validates :descricao, presence: true
  validates :ordem_no_calendario, uniqueness: true

  sig { void }
  def cadastrar_fornecedor_vacina_padrao
    fabricante_vacinas.new(descricao:)
  end

  sig { returns(T::Boolean) }
  def sem_fabricante_vacina?
    fabricante_vacinas.none?
  end
end
