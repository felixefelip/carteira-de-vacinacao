# typed: true

module Views::Caderneta
  class Index < Views::Base
    extend T::Sig

    sig { params(vacinas: ActiveRecord::Relation).void }
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
						vacinas.each { |vacina| render Views::Vacinas::Vacina.new(vacina) }
					end
				end
			end

			br

			a href: vacinas_path do
				"Adicionar Vacinação"
			end
    end

		private

		sig { returns(ActiveRecord::Relation) }
		attr_accessor :vacinas
  end
end
