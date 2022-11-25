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

  after_create :criar_calendario_de_vacinacao!
  after_save -> { recomendacao.recomendacao_vacinas.select(&:calcular_status_vacinal) }

  def idade
    (Date.current.strftime('%Y%m%d').to_i - data_nascimento.strftime('%Y%m%d').to_i) * 0.001
  end

  def qtde_doses_por_vacina(vacina)
    fabricante_vacinas.where(vacina: vacina).count
  end

  def qtde_doses_por_fabricante_vacina(fabricante_vacina)
    fabricante_vacinas.where(id: fabricante_vacina.id).count
  end

  def criar_calendario_de_vacinacao!
    vacinas_do_calendario = Vacina.where.not(ordem_no_calendario: nil)

    recomendacao = Recomendacao.create!(user_id: id)

    vacinas_do_calendario.each do |vacina|
      recomendacao.recomendacao_vacinas.create!(vacina: vacina)
    end
  end

  def atualizar_calendario
    recomendacao.recomendacao_vacinas.select(&:calcular_status_vacinal)
    recomendacao.save
  end
end
