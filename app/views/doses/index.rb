# typed: true

# Parece que não é usado essa action
module Views::Doses
  class Index < Views::Base
    extend T::Sig

    T::Sig::WithoutRuntime.sig { params(vacinas: Vacina::PrivateAssociationRelation).void }
    def initialize(vacinas:)
      super()
      self.vacinas = vacinas

      return unless vacina = vacinas.first

      vacina.descricao
    end

    def view_template
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

		T::Sig::WithoutRuntime.sig { returns(Vacina::PrivateAssociationRelation) }
		attr_accessor :vacinas


		sig { params(vacina: Vacina).void }
		def table_row_vacina(vacina)
			td { link_to 'Cadastrar dose', new_vacina_dose_path(vacina) }
			# td { link_to 'Destroy', vacina, method: :delete, data: { confirm: 'Are you sure?' } }
		end
  end
end
