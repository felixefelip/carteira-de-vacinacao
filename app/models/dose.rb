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
#  fabricante_vacina_id :integer          not null
#  user_id              :integer          not null
#
# Indexes
#
#  index_doses_on_fabricante_vacina_id  (fabricante_vacina_id)
#  index_doses_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (fabricante_vacina_id => fabricante_vacinas.id)
#  fk_rails_...  (user_id => users.id)
#
class Dose < ApplicationRecord
  belongs_to :user
  belongs_to :fabricante_vacina

  after_save -> { user.atualizar_calendario }

  delegate :vacina, to: :fabricante_vacina
end
