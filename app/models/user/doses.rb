module User
  class Doses
    attr_accessor :user, :fabricante_vacina

    def initialize(user)
      self.user = user
    end

    def qtde_por_fabricante_vacina(fabricante_vacina)
      user.fabricante_vacinas.where(id: fabricante_vacina.id).count
    end

    def qtde_por_vacina(vacina)
      user.fabricante_vacinas.where(vacina: vacina).count
    end
  end
end
