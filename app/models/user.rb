# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :doses, dependent: :destroy
  has_many :fabricante_vacinas, through: :doses
  has_many :vacinas, through: :fabricante_vacinas

  def qtde_doses_por_vacina(vacina)
    fabricante_vacinas.where(vacina: vacina).count
  end

  def qtde_doses_por_fabricante_vacina(fabricante_vacina)
    fabricante_vacinas.where(id: fabricante_vacina.id).count
  end
end
