# == Schema Information
#
# Table name: recomendacao_vacinas
#
#  id              :bigint           not null, primary key
#  status_vacinal  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recomendacao_id :bigint
#  vacina_id       :bigint
#
module RecomendacaoVacina
  # typed: true
  class Record < ApplicationRecord
    extend T::Sig

    self.table_name = 'recomendacao_vacinas'

    belongs_to :recomendacao, class_name: '::Recomendacao::Record'
    belongs_to :vacina, class_name: '::Vacina::Record'

    enum :status_vacinal, [:aguardando, :disponivel, :completo] # , default: :aguardando

    before_save :calcular_status_vacinal
  end
end
