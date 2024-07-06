# typed: true
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
  # typed: true
  class Record < ApplicationRecord
    extend T::Sig

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
    after_update -> { Caderneta::Vacinacao::Update.call!(self) }

    sig { returns(String) }
    def id_and_email
      return "" if created_at.nil?

      a = created_at_not_nil <= Date.current

      "a"
    end

    sig { returns(ActiveSupport::TimeWithZone) }
    def created_at_not_nil
      if self.created_at.nil?
        Date.current
      else
        created_at
      end
    end

    sig { void }
    def fazer_besteira
      10 / email.to_f

      id_and_email.to_f
    end
  end
end
