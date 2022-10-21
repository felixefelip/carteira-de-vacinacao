# == Schema Information
#
# Table name: doses
#
#  id                   :integer          not null, primary key
#  tipo                 :string
#  data_vacinacao       :date
#  lote_numero          :string
#  vacinador_codigo     :string
#  local_codigo         :string
#  user_id              :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fabricante_vacina_id :integer          not null
#
class Dose < ApplicationRecord
  belongs_to :user
  belongs_to :fabricante_vacina

  delegate :vacina, to: :fabricante_vacina
end
