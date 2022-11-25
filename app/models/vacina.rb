# == Schema Information
#
# Table name: vacinas
#
#  id                  :bigint           not null, primary key
#  descricao           :string
#  dias_de_intervalo   :integer
#  ordem_no_calendario :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Vacina < ApplicationRecord
  has_many :fabricante_vacinas, dependent: :destroy
  has_many :doses, through: :fabricante_vacinas

  has_many :recomendacao_vacinas, dependent: :destroy
  has_many :dose_do_calendarios, dependent: :destroy

  accepts_nested_attributes_for :fabricante_vacinas

  after_save :cadastrar_fornecedor_vacina_padrao

  validates :descricao, presence: true
  validates :ordem_no_calendario, uniqueness: true

  def cadastrar_fornecedor_vacina_padrao
    return if fabricante_vacinas.any?

    fabricante_vacinas.create!(descricao: descricao)
  end
end
