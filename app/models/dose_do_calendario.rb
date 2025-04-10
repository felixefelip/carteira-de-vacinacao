# typed: true

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
class DoseDoCalendario < ApplicationRecord
  self.table_name = 'dose_do_calendarios'

  belongs_to :vacina
end
