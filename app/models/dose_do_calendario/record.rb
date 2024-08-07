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
module DoseDoCalendario
  # typed: true
  class Record < ApplicationRecord
    self.table_name = 'dose_do_calendarios'

    belongs_to :vacina, class_name: '::Vacina::Record'
  end
end
