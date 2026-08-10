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

  # A conta é um login, não um paciente: quem tem caderneta é a pessoa. O dono
  # do login é a pessoa titular, criada junto com a conta e indestrutível.
  # Sem `dependent:` de propósito: quem destrói é o `has_many :pessoas` acima, e
  # repetir aqui destruiria a titular duas vezes.
  #
  # `where` e não o escopo `Pessoa.titulares`: o bloco é avaliado na relação de
  # Pessoa em tempo de execução, mas o Steep lê o `self` dele como singleton(User).
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_one :pessoa_titular, -> { where(titular: true) }, class_name: 'Pessoa', inverse_of: :user
  # rubocop:enable Rails/HasManyOrHasOneDependent

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
