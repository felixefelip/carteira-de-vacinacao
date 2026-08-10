# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  has_many :pessoas, dependent: :destroy, inverse_of: :user

  has_one :pessoa_titular, -> { where(titular: true) }, class_name: 'Pessoa', inverse_of: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :pessoa_titular

  validates :pessoa_titular, presence: true

  before_validation :preparar_pessoa_titular

  private

  def preparar_pessoa_titular
    pessoa = pessoa_titular || build_pessoa_titular

    pessoa.titular = true
    pessoa.email = email
  end
end
