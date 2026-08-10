class Pessoa
  module Avatar
    extend ActiveSupport::Concern

    TIPOS_ACEITOS = %w[image/png image/jpeg image/webp].freeze
    TAMANHO_MAXIMO = 5.megabytes

    included do
      has_one_attached :avatar

      validate :avatar_precisa_ser_uma_imagem_pequena
    end

    def iniciais
      nome.to_s.split.first(2).map(&:first).join.upcase
    end

    private

    def avatar_precisa_ser_uma_imagem_pequena
      return unless (blob = avatar.blob)

      errors.add(:avatar, 'precisa ser PNG, JPEG ou WEBP') unless TIPOS_ACEITOS.include?(blob.content_type)
      return unless blob.byte_size > TAMANHO_MAXIMO

      errors.add(:avatar, "precisa ter no máximo #{TAMANHO_MAXIMO / 1.megabyte} MB")
    end
  end
end
