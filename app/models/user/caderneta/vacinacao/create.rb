module User::Caderneta::Vacinacao
  class Create
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def self.call!(user)
      new(user).call!
    end

    def call!
      criar_calendario_de_vacinacao!
    end

    def criar_calendario_de_vacinacao!
      vacinas_do_calendario = ::Vacina::Record.where.not(ordem_no_calendario: nil)

      recomendacao = ::Recomendacao::Record.create!(user_id: user.id)

      vacinas_do_calendario.each do |vacina|
        recomendacao.recomendacao_vacinas.create!(vacina: vacina)
      end
    end
  end
end
