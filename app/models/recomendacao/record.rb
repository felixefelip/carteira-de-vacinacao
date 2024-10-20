# == Schema Information
#
# Table name: recomendacaos
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
module Recomendacao
  # typed: true
  class Record < ApplicationRecord
    self.table_name = 'recomendacaos'

    extend T::Sig

    belongs_to :user, class_name: '::User::Record'
    has_many :recomendacao_vacinas,
             dependent: :destroy,
             class_name: '::RecomendacaoVacina::Record',
             foreign_key: :recomendacao_id,
             inverse_of: :recomendacao

    has_many :vacinas, through: :recomendacao_vacinas
  end
end
