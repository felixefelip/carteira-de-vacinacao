# typed: true

module Views::Vacinas
  class Index < Views::Base
    extend T::Sig

    sig { params(vacinas: ActiveRecord::Relation).void }
    def initialize(vacinas:)
      super()
      @vacinas = vacinas
    end

		def view_template
			p(id: "notice") { notice }

			h1 { "Escolha uma vacina" }

			div class: "table-responsive-md" do
				table class: "table table-striped table-bordered table-hover mt-4 shadow-sm" do
					thead class: "thead-light" do
						tr do
							th { "Descricao" }
							th colspan: "3"
						end
					end

					tbody do
						@vacinas.each do |vacina|
              table_row_vacina(vacina)
						end
					end
				end
			end

			br
			link_to 'Criar Vacina', new_vacina_path
			br
			br

			hr

			br
			br
			br
			br
		end

		private

		sig { returns(ActiveRecord::Relation) }
		attr_reader :vacinas

		sig { params(vacina: Vacina::Record).void }
    def table_row_vacina(vacina)
      tr do
				td { vacina.descricao }
				td { link_to 'Cadastrar dose', new_vacina_dose_path(vacina) }
			end
    end
  end
end
