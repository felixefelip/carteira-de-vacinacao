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

  TIPOS_DE_FOTO_ACEITOS = %w[image/png image/jpeg image/webp].freeze
  TAMANHO_MAXIMO_DA_FOTO = 5.megabytes

  belongs_to :user
  has_one :caderneta, dependent: :destroy, touch: true
  has_one_attached :foto

  normalizes :email, with: ->(email) { email.strip.downcase.presence }

  validates :nome, presence: true
  validates :data_nascimento, presence: true
  validates :data_nascimento, comparison: { less_than: -> { Date.current }, message: 'não pode ser no futuro' }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :caderneta, presence: true
  validate :email_nao_pode_ser_de_outra_conta
  validate :foto_precisa_ser_uma_imagem_pequena

  before_validation :montar_caderneta

  scope :titulares, -> { where(titular: true) }
  scope :por_nome, -> { order(titular: :desc, nome: :asc) }

  def iniciais
    nome.to_s.split.first(2).map(&:first).join.upcase
  end

  private

  def montar_caderneta
    caderneta || build_caderneta
  end

  def email_nao_pode_ser_de_outra_conta
    return if titular? || email.blank?
    return unless User.exists?(email:)

    errors.add(:email, 'já pertence a outra conta')
  end

  def foto_precisa_ser_uma_imagem_pequena
    return unless (blob = foto.blob)

    errors.add(:foto, 'precisa ser PNG, JPEG ou WEBP') unless TIPOS_DE_FOTO_ACEITOS.include?(blob.content_type)
    return unless blob.byte_size > TAMANHO_MAXIMO_DA_FOTO

    errors.add(:foto, "precisa ter no máximo #{TAMANHO_MAXIMO_DA_FOTO / 1.megabyte} MB")
  end
end
