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

    self.table_name = 'users'

    include Idade

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_one :recomendacao,
            dependent: :destroy,
            foreign_key: :user_id,
            class_name: '::Recomendacao::Record',
            inverse_of: :user

    has_many :doses,
             dependent: :destroy,
             foreign_key: :user_id,
             class_name: '::Dose::Record',
             inverse_of: :user

    has_many :fabricante_vacinas,
             through: :doses,
             foreign_key: :user_id,
             class_name: '::FabricanteVacina::Record'

    has_many :vacinas,
             through: :fabricante_vacinas,
             foreign_key: :user_id,
             class_name: '::Vacina::Record'

    validates :email, :data_nascimento, presence: true

    # after_create :criar_cardeneta_de_vacinacao
    # after_update :atualizar_cardeneta_de_vacinacao

    sig { void }
    def criar_cardeneta_de_vacinacao
      Caderneta::Vacinacao::Create.call!(self)
    end

    sig { void }
    def atualizar_cardeneta_de_vacinacao
      Caderneta::Vacinacao::Update.call!(self)
    end
  end
end
