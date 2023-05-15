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
module User
  class Record < ApplicationRecord
    self.table_name = "users"

    include Idade

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_one :recomendacao, **{
      dependent: :destroy,
      foreign_key: :user_id,
      class_name: "::Recomendacao::Record",
    }

    has_many :doses, **{
      dependent: :destroy,
      foreign_key: :user_id,
      class_name: "::Dose::Record",
    }

    has_many :fabricante_vacinas, **{
      through: :doses,
      foreign_key: :user_id,
      class_name: "::FabricanteVacina::Record",
    }

    has_many :vacinas, **{
      through: :fabricante_vacinas,
      foreign_key: :user_id,
      class_name: "::Vacina::Record",
    }

    validates :email, :data_nascimento, presence: true

    after_create -> { Caderneta::Vacinacao::Create.call!(self) }
    after_save -> { Caderneta::Vacinacao::Update.call!(self) }

    def qtde_doses_por_vacina(vacina)
      fabricante_vacinas.where(vacina: vacina).count
    end

    def qtde_doses_por_fabricante_vacina(fabricante_vacina)
      fabricante_vacinas.where(id: fabricante_vacina.id).count
    end
  end
end
