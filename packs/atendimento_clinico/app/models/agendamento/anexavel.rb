class Agendamento
  module Anexavel
    extend ActiveSupport::Concern

    TIPOS_ACEITOS = %w[application/pdf image/png image/jpeg image/webp].freeze
    TAMANHO_MAXIMO = 10.megabytes

    included do
      has_many_attached :anexos

      validate :anexos_precisam_ser_arquivos_aceitos
    end

    private

    def anexos_precisam_ser_arquivos_aceitos
      anexos.each { |anexo| validar_anexo(anexo.blob) }
    end

    def validar_anexo(blob)
      unless TIPOS_ACEITOS.include?(blob.content_type)
        errors.add(:anexos, "#{blob.filename} precisa ser PDF, PNG, JPEG ou WEBP")
      end

      return unless blob.byte_size > TAMANHO_MAXIMO

      errors.add(:anexos, "#{blob.filename} precisa ter no máximo #{TAMANHO_MAXIMO / 1.megabyte} MB")
    end
  end
end
