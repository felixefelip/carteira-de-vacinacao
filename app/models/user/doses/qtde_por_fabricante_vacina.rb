module User::Doses
  class QtdePorFabricanteVacina
    attr_accessor :user, :fabricante_vacina

    def initialize(user, fabricante_vacina)
      self.user = user
      self.fabricante_vacina = fabricante_vacina
    end

    def self.call(user, fabricante_bacina)
      new(user, fabricante_bacina).call
    end

    def call
      user.fabricante_vacinas.where(id: fabricante_vacina.id).count
    end
  end
end
