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
  belongs_to :vacina
end
