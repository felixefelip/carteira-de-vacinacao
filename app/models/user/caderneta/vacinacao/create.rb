module User::Caderneta::Vacinacao
  # typed: true
  class Create
    extend T::Sig

    attr_accessor :user

    sig { params(user: User::Record).void }
    def initialize(user)
      @user = user
    end

    sig { params(user: User::Record).void }
    def self.call!(user)
      new(user).call!
    end

    sig { void }
    def call!
      criar_calendario_de_vacinacao!
    end

    sig { void }
    def criar_calendario_de_vacinacao!
      vacinas_do_calendario = ::Vacina::Record.where.not(ordem_no_calendario: nil)

      recomendacao = ::Recomendacao::Record.create!(user_id: user.id)

      vacinas_do_calendario.each do |vacina|
        recomendacao.recomendacao_vacinas.create!(vacina: vacina)
      end
    end
  end
end
