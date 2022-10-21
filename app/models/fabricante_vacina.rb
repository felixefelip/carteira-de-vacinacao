# == Schema Information
#
# Table name: fabricante_vacinas
#
#  id         :integer          not null, primary key
#  descricao  :string
#  user_id    :integer
#  vacina_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FabricanteVacina < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :vacina

  has_many :doses, dependent: :destroy
end
