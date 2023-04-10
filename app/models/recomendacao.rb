# == Schema Information
#
# Table name: recomendacaos
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class Recomendacao < ApplicationRecord
  belongs_to :user
  has_many :recomendacao_vacinas, dependent: :destroy

  has_many :vacinas, through: :recomendacao_vacinas
end
