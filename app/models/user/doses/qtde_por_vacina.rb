module User::Doses
  class QtdePorVacina
    attr_accessor :user, :fabricante_vacina

    def initialize(user, fabricante_vacina)
      self.user = user
      self.fabricante_vacina = fabricante_vacina
    end

    def self.call(user, fabricante_bacina)
      new(user, fabricante_bacina).call
    end

    def call
      user.fabricante_vacinas.where(vacina: vacina).count
    end
  end
end
