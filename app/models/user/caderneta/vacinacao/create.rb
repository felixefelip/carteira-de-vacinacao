# typed: true

module User::Caderneta::Vacinacao
  class Create
    extend T::Sig

    sig { params(user: User).void }
    def initialize(user)
      self.user = user
    end

    sig { params(user: User).void }
    def self.call(user)
      new(user).call
    end

    sig { void }
    def call
      criar_calendario_de_vacinacao!
    end

    private

    sig { returns(User) }
    attr_accessor :user

    sig { void }
    def criar_calendario_de_vacinacao!
      vacinas_do_calendario = ::Vacina.where.not(ordem_no_calendario: nil)

      vacinas_do_calendario.each do |vacina|
        user.recomendacao_vacinas.create!(vacina:)
      end
    end
  end
end
