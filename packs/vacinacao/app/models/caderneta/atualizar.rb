class Caderneta
  class Atualizar
    def initialize(caderneta)
      @caderneta = caderneta
    end

    def call
      atualizar_calendario!
    end

    private

    attr_reader :caderneta

    def atualizar_calendario!
      caderneta.recomendacao_vacinas.each do |recomendacao_vacina|
        recomendacao_vacina.calcular_status_vacinal
        recomendacao_vacina.save!
      end
    end
  end
end
