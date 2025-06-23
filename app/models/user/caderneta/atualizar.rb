# typed: true

class User::Caderneta
  class Atualizar
    extend T::Sig

    #: (User::Caderneta) -> void
    def initialize(caderneta)
      @caderneta = caderneta
    end

    #: -> void
    def call
      atualizar_calendario!
    end

    private

    sig { returns(User::Caderneta) }
    attr_reader :caderneta

    #: -> void
    def atualizar_calendario!
      caderneta.recomendacao_vacinas.each do |recomendacao_vacina|
        recomendacao_vacina.calcular_status_vacinal
        recomendacao_vacina.save!
      end
    end
  end
end
