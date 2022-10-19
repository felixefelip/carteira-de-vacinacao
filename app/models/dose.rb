# == Schema Information
#
# Table name: doses
#
#  id         :integer          not null, primary key
#  tipo       :string
#  vacina_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dose < ApplicationRecord
  belongs_to :vacina

  has_many :user_doses, dependent: :destroy
  has_many :users, through: :user_doses

  validates :tipo, presence: true
end
