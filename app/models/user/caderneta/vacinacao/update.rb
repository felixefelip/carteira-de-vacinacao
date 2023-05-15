module User::Caderneta::Vacinacao
  class Update
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def self.call!(user)
      new(user).call!
    end

    def call!
      atualizar_calendario!
    end

    def atualizar_calendario!
      user.recomendacao.recomendacao_vacinas.each do |recomendacao_vacina|
        recomendacao_vacina.calcular_status_vacinal
        recomendacao_vacina.save!
      end
    end
  end
end
