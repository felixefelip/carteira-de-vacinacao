# == Schema Information
#
# Table name: vacinas
#
#  id                :bigint           not null, primary key
#  descricao         :string
#  dias_de_intervalo :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Vacina < ApplicationRecord
  has_many :fabricante_vacinas, dependent: :destroy
  has_many :doses, through: :fabricante_vacinas

  has_many :recomendacao_vacinas, dependent: :destroy
  has_many :dose_do_calendarios, dependent: :destroy

  accepts_nested_attributes_for :fabricante_vacinas

  validates :descricao, presence: true
end
