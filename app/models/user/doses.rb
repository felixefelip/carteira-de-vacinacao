# typed: true

class User
  class Doses
    extend T::Sig

    attr_accessor :user, :fabricante_vacina

    sig { params(user: User).void }
    def initialize(user)
      self.user = user
    end

    sig { params(fabricante_vacina: FabricanteVacina).returns(Integer) }
    def qtde_por_fabricante_vacina(fabricante_vacina)
      user.fabricante_vacinas.where(id: fabricante_vacina.id).count
    end

    sig { params(vacina: Vacina).returns(Integer) }
    def qtde_por_vacina(vacina)
      user.fabricante_vacinas.where(vacina: vacina).count
    end
  end
end
