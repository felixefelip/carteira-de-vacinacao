# typed: true

module Views::Caderneta
  class Doses < Views::Base
    extend T::Sig

    sig { params(vacina: ::Vacina).void }
    def initialize(vacina)
      super()
      self.vacina = vacina
    end

    def view_template
			tr do
				td do
					link_to vacina.descricao, cadernetum_path(vacina.id)
				end
				td do
					"#{Current.caderneta!.qtde_por_vacina(vacina)} doses"
				end
				td do
					link_to 'Editar', edit_vacina_path(vacina)
				end
				td do
					link_to 'Remover', vacina_doses_path(vacina), data: { turbo: true, turbo_method: :delete, turbo_confirm: 'Are you sure?' }
				end
			end
    end

		private

		sig { returns(::Vacina) }
		attr_accessor :vacina
  end
end
