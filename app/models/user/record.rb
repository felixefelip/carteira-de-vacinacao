# typed: true

module User
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

    has_many :recomendacao_vacinas,
             through: :recomendacao,
             foreign_key: :user_id,
             class_name: '::Recomendacao::Record'

    validates :email, :data_nascimento, presence: true
    validates :data_nascimento, comparison: { less_than: -> { Date.current }, message: 'não pode ser no futuro' }

    after_create :criar_caderneta_de_vacinacao
    after_update :atualizar_caderneta_de_vacinacao

    sig { void }
    def criar_caderneta_de_vacinacao
      Caderneta::Vacinacao::Create.call(self)
    end

    sig { void }
    def atualizar_caderneta_de_vacinacao
      Caderneta::Vacinacao::Update.call(self)
    end
  end
end
