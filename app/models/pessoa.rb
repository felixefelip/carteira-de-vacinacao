# == Schema Information
#
# Table name: pessoas
#
#  id              :bigint           not null, primary key
#  data_nascimento :date             not null
#  email           :string
#  nome            :string           not null
#  titular         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
class Pessoa < ApplicationRecord
  include Idade
  include Avatar

  belongs_to :user
  has_one :caderneta, dependent: :destroy, touch: true

  normalizes :email, with: ->(email) { email.strip.downcase.presence }

  validates :nome, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :caderneta, presence: true
  validate :email_nao_pode_ser_de_outra_conta

  before_validation :montar_caderneta

  scope :titulares, -> { where(titular: true) }
  scope :por_nome, -> { order(titular: :desc, nome: :asc) }

  private

  def montar_caderneta
    caderneta || build_caderneta
  end

  def email_nao_pode_ser_de_outra_conta
    return if titular? || email.blank?
    return unless User.exists?(email:)

    errors.add(:email, 'já pertence a outra conta')
  end
end
