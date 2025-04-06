# typed: true

module Views::Vacina::Records
  class Record < Views::Base
    extend T::Sig

    sig { params(vacina: Vacina::Record).void }
    def initialize(vacina)
      super()
      @vacina = vacina
    end

    def view_template
			tr do
				td do
					link_to vacina.descricao, cadernetum_path(vacina.id)
				end
				td do
					"#{::User::Doses.new(helpers.current_user!).qtde_por_vacina(vacina)} doses"
				end
				td do
					link_to 'Editar', edit_vacina_path(vacina)
				end
				td do
					link_to 'Remover', vacina_doses_path(vacina), method: :delete, data: { confirm: 'Are you sure?' }
				end
			end
    end

		private

		sig { returns(Vacina::Record) }
		attr_reader :vacina
  end
end
