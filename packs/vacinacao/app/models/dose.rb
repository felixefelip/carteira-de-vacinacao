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
#  caderneta_id         :bigint           not null
#  fabricante_vacina_id :bigint           not null
#
class Dose < ApplicationRecord
  belongs_to :caderneta
  belongs_to :fabricante_vacina

  after_save :atualizar_calendario

  def atualizar_calendario
    caderneta.atualizar_caderneta_de_vacinacao
  end
end
