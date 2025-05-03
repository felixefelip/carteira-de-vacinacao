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
class User < ApplicationRecord
  extend T::Sig

  include Idade

  has_one :caderneta, dependent: :destroy, touch: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :data_nascimento, presence: true
  validates :data_nascimento, comparison: { less_than: -> { Date.current }, message: 'não pode ser no futuro' }

  before_validation :set_user_dose_na_criacao

  sig { returns(Caderneta) }
  def caderneta!
    T.must(caderneta)
  end

  sig { void }
  def set_user_dose_na_criacao
    caderneta || build_caderneta
  end
end
