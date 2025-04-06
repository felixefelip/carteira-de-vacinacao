# typed: true

module Views::Sugestoes
  class Index < Views::Base
    extend T::Sig

    sig { params(recomendacao_vacinas: ActiveRecord::Relation).void }
    def initialize(recomendacao_vacinas)
      super()
      self.recomendacao_vacinas = recomendacao_vacinas
    end

    def view_template
			p(id: "notice") { notice }

      h1 { "Calendário de Vacinação" }
      span { "Idade: #{Current.user!.idade_formatada}." }
			div class: "table-responsive-md" do
				table class: "table table-striped table-bordered table-hover mt-4 shadow-sm" do
					thead class: "thead-light" do
						tr do
							th { "Descricao" }
							th { "Doses tomadas" }
							th { "Situação" }
							th colspan: "3"
						end
					end

					tbody do
						recomendacao_vacinas.each do |recomendacao_vacina|
							table_row_recomendacao_vacina(recomendacao_vacina)
						end
					end
				end
			end

			br

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
		attr_accessor :recomendacao_vacinas

		sig { params(recomendacao_vacina: RecomendacaoVacina::Record).void }
    def table_row_recomendacao_vacina(recomendacao_vacina)
			tr do
				td { recomendacao_vacina.vacina&.descricao }
				td { recomendacao_vacina.qtde_doses_tomadas }
				td { "#{recomendacao_vacina.status_vacinal} #{exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)}" }
				td { link_to 'Cadastrar dose', new_vacina_dose_path(recomendacao_vacina.vacina) }
			end
    end

		sig { params(recomendacao_vacina: RecomendacaoVacina::Record).returns(String) }
		def exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)
			return '' if recomendacao_vacina.status_vacinal != 'aguardando'

			" - disponível em: #{recomendacao_vacina.quando_pode_tomar_proxima_dose&.strftime('%d/%m/%Y')}"
		end
  end
end
