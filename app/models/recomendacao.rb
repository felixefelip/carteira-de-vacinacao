# == Schema Information
#
# Table name: recomendacaos
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_recomendacaos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recomendacao < ApplicationRecord
  belongs_to :user
  has_many :recomendacao_vacinas, dependent: :destroy

  has_many :vacinas, through: :recomendacao_vacinas
end
