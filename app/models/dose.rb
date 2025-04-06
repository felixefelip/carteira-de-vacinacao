# typed: true

# == Schema Information
#
# Table name: doses
#
#  id                   :bigint           not null, primary key
#  data_vacinacao       :date
#  local_codigo         :string
#  lote_numero          :string
#  tipo                 :string
#  vacinador_codigo     :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fabricante_vacina_id :bigint           not null
#  user_id              :bigint           not null
#
class Dose < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :fabricante_vacina

  after_save :atualizar_calendario

  delegate :vacina, to: :fabricante_vacina

  def atualizar_calendario
    user&.atualizar_caderneta_de_vacinacao
  end
end
