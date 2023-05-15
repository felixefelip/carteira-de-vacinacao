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
module Dose
  class Record < ApplicationRecord
    self.table_name = "doses"

    belongs_to :user, **{
      class_name: "::User::Record",
    }

    belongs_to :fabricante_vacina, **{
      class_name: "::FabricanteVacina::Record",
    }

    after_save -> { user.atualizar_calendario }

    delegate :vacina, to: :fabricante_vacina
  end
end
