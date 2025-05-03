# typed: true

class User::Caderneta
  class Cadastrar
    extend T::Sig

    sig { params(caderneta: User::Caderneta).void }
    def initialize(caderneta)
      self.caderneta = caderneta
    end

    sig { void }
    def call
      criar_calendario_de_vacinacao!
    end

    private

    sig { returns(User::Caderneta) }
    attr_accessor :caderneta

    sig { void }
    def criar_calendario_de_vacinacao!
      ApplicationRecord.transaction do
        vacinas_do_calendario = ::Vacina.where.not(ordem_no_calendario: nil)

        vacinas_do_calendario.each do |vacina|
          caderneta.recomendacao_vacinas.create!(vacina:)
        end
      end
    end
  end
end
