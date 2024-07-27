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
module Vacina
  # typed: true
  class Record < ApplicationRecord
    extend T::Sig

    self.table_name = 'vacinas'

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

    after_save :cadastrar_fornecedor_vacina_padrao

    validates :descricao, presence: true
    validates :ordem_no_calendario, uniqueness: true

    sig { void }
    def cadastrar_fornecedor_vacina_padrao
      return if fabricante_vacinas.any?

      fabricante_vacinas.create!(descricao: descricao)
    end
  end
end
