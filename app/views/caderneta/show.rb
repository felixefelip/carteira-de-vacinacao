# typed: true

module Views::Caderneta
  class Show < Views::Base
    extend T::Sig

    T::Sig::WithoutRuntime.sig { params(vacina: Vacina, fabricante_vacinas: FabricanteVacina::PrivateAssociationRelation).void }
    def initialize(vacina:, fabricante_vacinas:)
      super()
			self.vacina = vacina
      self.fabricante_vacinas = fabricante_vacinas
    end

    def view_template
			p(id: "notice") { notice }

			h3 do
				span { "Doses tomadas da vacina " }
				strong { vacina.descricao }
			end

			div(class: "table-responsive-md") do
				table(class: "table table-striped table-bordered table-hover mt-4 shadow-sm") do
					thead(class: "thead-light") do
						tr do
							th { "Descricao" }
							th { "Qtde de doses" }
							th(colspan: "3")
						end
					end

					tbody do
						fabricante_vacinas.each do |fabricante_vacina|
              table_row_fabricante_vacina(fabricante_vacina)
						end
					end
				end
			end

			helpers.link_to('Voltar', :back)
    end

		private

		sig { returns(Vacina) }
		attr_accessor :vacina

		T::Sig::WithoutRuntime.sig { returns(FabricanteVacina::PrivateAssociationRelation) }
		attr_accessor :fabricante_vacinas

		sig { params(fabricante_vacina: FabricanteVacina).void }
		def table_row_fabricante_vacina(fabricante_vacina)
			tr do
				td { fabricante_vacina.descricao }
				td { "#{Current.caderneta!.qtde_por_fabricante_vacina(fabricante_vacina)} doses" }
				td do
					helpers.link_to('Destroy', fabricante_vacina_path(fabricante_vacina), method: :delete, data: { confirm: 'Are you sure?' })
				end
			end
		end
  end
end
