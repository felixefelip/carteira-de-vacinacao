# typed: true

class Caderneta
  class Cadastrar
    extend T::Sig

    #: (Caderneta) -> void
    def initialize(caderneta)
      self.caderneta = caderneta
    end

    #: -> void
    def call
      criar_calendario_de_vacinacao!
    end

    private

    #: Caderneta
    attr_accessor :caderneta

    #: -> void
    def criar_calendario_de_vacinacao!
      ApplicationRecord.transaction do
        vacinas_do_calendario = ::Vacina.where.not(ordem_no_calendario: nil)

        vacinas_do_calendario.each do |vacina|
          next if caderneta.recomendacao_vacinas.map(&:vacina).include?(vacina)

          caderneta.recomendacao_vacinas.create!(vacina:)
        end
      end
    end
  end
end
