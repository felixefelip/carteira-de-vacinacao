# == Schema Information
#
# Table name: especialidades
#
#  id         :bigint           not null, primary key
#  nome       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Especialidade < ApplicationRecord
  has_many :profissionais, dependent: :restrict_with_exception
  has_many :agendamentos, dependent: :restrict_with_exception
  has_many :consultas, dependent: :restrict_with_exception

  validates :nome, presence: true, uniqueness: true
end
