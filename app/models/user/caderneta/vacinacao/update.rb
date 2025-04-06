# typed: true

module User::Caderneta::Vacinacao
  class Update
    extend T::Sig

    sig { params(user: User::Record).void }
    def initialize(user)
      @user = user
    end

    sig { params(user: User::Record).void }
    def self.call(user)
      new(user).call
    end

    def call
      atualizar_calendario!
    end

    private

    sig { returns(User::Record) }
    attr_reader :user

    def atualizar_calendario!
      user.recomendacao&.recomendacao_vacinas&.each do |recomendacao_vacina|
        recomendacao_vacina.calcular_status_vacinal
        recomendacao_vacina.save!
      end
    end
  end
end
