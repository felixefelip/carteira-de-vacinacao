# typed: true

class User::Caderneta
  class Atualizar
    extend T::Sig

    sig { params(caderneta: User::Caderneta).void }
    def initialize(caderneta)
      @caderneta = caderneta
    end

    sig { params(caderneta: User::Caderneta).void }
    def self.call(caderneta)
      new(caderneta).call
    end

    def call
      atualizar_calendario!
    end

    private

    sig { returns(User::Caderneta) }
    attr_reader :caderneta

    def atualizar_calendario!
      caderneta.recomendacao_vacinas.each do |recomendacao_vacina|
        recomendacao_vacina.calcular_status_vacinal
        recomendacao_vacina.save!
      end
    end
  end
end
