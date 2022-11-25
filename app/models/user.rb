# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  data_nascimento        :date
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :recomendacao, dependent: :destroy
  has_many :doses, dependent: :destroy

  has_many :fabricante_vacinas, through: :doses
  has_many :vacinas, through: :fabricante_vacinas

  def idade
  end

  def qtde_doses_por_vacina(vacina)
    fabricante_vacinas.where(vacina: vacina).count
  end

  def qtde_doses_por_fabricante_vacina(fabricante_vacina)
    fabricante_vacinas.where(id: fabricante_vacina.id).count
  end

  def situacao_na_vacina(vacina)

    fabricante_vacinas.where(vacina: vacina).count
  end
end
