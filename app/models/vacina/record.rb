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
# typed: true
class Vacina::Record < ApplicationRecord
  extend T::Sig

  self.table_name = 'vacinas'

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Record')
  end

  has_many :fabricante_vacinas, **{
    dependent: :destroy,
    foreign_key: :vacina_id,
    class_name: 'FabricanteVacina::Record',
  }

  has_many :doses, ** {
    through: :fabricante_vacinas,
    class_name: '::FabricanteVacina::Record',
  }

  has_many :recomendacao_vacinas, **{
    dependent: :destroy,
    foreign_key: :vacina_id,
    class_name: '::RecomendacaoVacina::Record',
  }

  has_many :dose_do_calendarios, **{
    dependent: :destroy,
    foreign_key: :vacina_id,
    class_name: '::DoseDoCalendario::Record',
  }

  accepts_nested_attributes_for :fabricante_vacinas

  after_create :cadastrar_fornecedor_vacina_padrao, if: :sem_fabricante_vacina?

  validates :descricao, presence: true
  validates :ordem_no_calendario, uniqueness: true

  sig { void }
  def cadastrar_fornecedor_vacina_padrao
    fabricante_vacinas.create!(descricao: descricao)
  end

  sig { returns(T::Boolean) }
  def sem_fabricante_vacina?
    fabricante_vacinas.none?
  end
end
