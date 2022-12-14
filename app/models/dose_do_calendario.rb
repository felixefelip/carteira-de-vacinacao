# == Schema Information
#
# Table name: dose_do_calendarios
#
#  id                :bigint           not null, primary key
#  idade_recomendada :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  vacina_id         :bigint
#
# Indexes
#
#  index_dose_do_calendarios_on_vacina_id  (vacina_id)
#
# Foreign Keys
#
#  fk_rails_...  (vacina_id => vacinas.id)
#
class DoseDoCalendario < ApplicationRecord
  belongs_to :vacina
end
