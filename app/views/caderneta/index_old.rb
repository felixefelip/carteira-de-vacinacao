# typed: true

module Views::Caderneta
  class IndexOld < Views::Base
    extend T::Sig

    #: (vacinas: Vacina::PrivateAssociationRelation) -> void
    def initialize(vacinas:)
      super()
      self.vacinas = vacinas
    end

    def view_template
			h1 { "Caderneta de Vacinação" }

			div class: "table-responsive-md" do
				table class: "table table-striped table-bordered table-hover mt-4 shadow-sm" do
					thead class: "thead-light" do
						tr do
							th { "Vacinas" }
							th { "Qtde de doses" }
							th colspan: 3
						end
					end

					tbody do
						vacinas.each { |vacina| render Views::Caderneta::Doses.new(vacina) }
					end
				end
			end

			br

			link_to "Adicionar Vacinação", vacinas_path
    end

		private

		#: Vacina::PrivateAssociationRelation
		attr_accessor :vacinas
  end
end
