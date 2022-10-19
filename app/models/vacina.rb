# == Schema Information
#
# Table name: vacinas
#
#  id         :integer          not null, primary key
#  descricao  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vacina < ApplicationRecord
  has_many :doses, dependent: :destroy
end
