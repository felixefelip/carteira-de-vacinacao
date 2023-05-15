# == Schema Information
#
# Table name: fabricante_vacinas
#
#  id         :bigint           not null, primary key
#  descricao  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  vacina_id  :bigint           not null
#
module FabricanteVacina
  class Record < ApplicationRecord
    self.table_name = "fabricante_vacinas"

    belongs_to :user, optional: true
    belongs_to :vacina, dependent: :destroy, class_name: "Vacina::Record"

    has_many :doses, dependent: :nullify
  end
end
