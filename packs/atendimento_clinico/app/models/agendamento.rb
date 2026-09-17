# == Schema Information
#
# Table name: agendamentos
#
#  id                   :bigint           not null, primary key
#  duracao_minutos      :integer
#  especialidade        :string
#  estabelecimento_nome :string
#  inicio_em            :datetime         not null
#  motivo               :string           not null
#  observacoes          :text
#  pago_em              :date
#  profissional_nome    :string
#  status               :string           default("agendado"), not null
#  valor                :decimal(10, 2)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  pessoa_id            :bigint           not null
#
class Agendamento < ApplicationRecord
  TIPOS_DE_ANEXO_ACEITOS = %w[application/pdf image/png image/jpeg image/webp].freeze
  TAMANHO_MAXIMO_DO_ANEXO = 10.megabytes

  belongs_to :pessoa
  has_many_attached :anexos

  enum :status, {
    agendado: 'agendado',
    realizado: 'realizado',
    cancelado: 'cancelado',
  }, default: :agendado, validate: true

  validates :motivo, :inicio_em, presence: true
  validates :duracao_minutos, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :valor, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :anexos_precisam_ser_arquivos_aceitos

  def pago?
    pago_em.present?
  end

  private

  def anexos_precisam_ser_arquivos_aceitos
    anexos.each { |anexo| validar_anexo(anexo.blob) }
  end

  def validar_anexo(blob)
    unless TIPOS_DE_ANEXO_ACEITOS.include?(blob.content_type)
      errors.add(:anexos, "#{blob.filename} precisa ser PDF, PNG, JPEG ou WEBP")
    end

    return unless blob.byte_size > TAMANHO_MAXIMO_DO_ANEXO

    errors.add(:anexos, "#{blob.filename} precisa ter no máximo #{TAMANHO_MAXIMO_DO_ANEXO / 1.megabyte} MB")
  end
end
