# typed: true

# Parece que não é usado essa action
module Views::Doses
  class Index < Views::Base
    extend T::Sig

    sig { params(vacinas: ActiveRecord::Relation).void }
    def initialize(vacinas:)
      super()
      @vacinas = vacinas
    end

    def view_template
      byebug
      p(id: "notice") { notice }

      h1 { "Vacinas tomadas" }

      table do
        thead do
          tr do
            th { "Descricao" }
            th colspan: "3"
          end
        end

        tbody do
          @vacinas.each { |vacina| table_row_vacina(vacina) }
        end

        br

        link_to 'Nova Vacina', new_vacina_path
      end
    end

		private

		sig { returns(ActiveRecord::Relation) }
		attr_reader :vacinas


		sig { params(vacina: Vacina::Record).void }
		def table_row_vacina(vacina)
			td { link_to 'Cadastrar dose', new_vacina_dose_path(vacina) }
			td { link_to 'Destroy', vacina, method: :delete, data: { confirm: 'Are you sure?' } }
		end
  end
end
