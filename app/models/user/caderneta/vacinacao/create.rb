# typed: true

module User::Caderneta::Vacinacao
  class Create
    extend T::Sig

    sig { params(user: User::Record).void }
    def initialize(user)
      self.user = user
    end

    sig { params(user: User::Record).void }
    def self.call(user)
      new(user).call
    end

    sig { void }
    def call
      criar_calendario_de_vacinacao!
    end

    private

    sig { returns(User::Record) }
    attr_accessor :user

    sig { void }
    def criar_calendario_de_vacinacao!
      vacinas_do_calendario = ::Vacina::Record.where.not(ordem_no_calendario: nil)

      recomendacao = ::Recomendacao::Record.create!(user_id: user.id)

      vacinas_do_calendario.each do |vacina|
        RecomendacaoVacina::Cadastrar.call(recomendacao, vacina)
      end
    end
  end
end
