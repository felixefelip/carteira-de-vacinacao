# typed: true

module Views::Sugestoes
  class Index < Views::Base
    extend T::Sig

		#: (User::Caderneta::RecomendacaoVacina::PrivateAssociationRelation) -> void
    def initialize(recomendacao_vacinas)
      super()
      self.recomendacao_vacinas = recomendacao_vacinas
    end

    def view_template
			p(id: "notice") { notice }

      h1 { "Calendário de Vacinação" }
      div class: "age-info mb-4" do
        span { "🎂 Idade atual: #{Current.user!.idade_formatada}" }
      end
      
			div class: "table-responsive-md" do
				table class: "table table-striped table-bordered table-hover mt-4 shadow-sm" do
					thead class: "thead-light" do
						tr do
							th { "Vacina" }
							th { "Doses Tomadas" }
							th { "Situação" }
							th { "Ação" }
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
			hr
    end

		private

		T::Sig::WithoutRuntime.sig { returns(User::Caderneta::RecomendacaoVacina::PrivateAssociationRelation) }
		attr_accessor :recomendacao_vacinas

		sig { params(recomendacao_vacina: User::Caderneta::RecomendacaoVacina).void }
    def table_row_recomendacao_vacina(recomendacao_vacina)
			tr class: "vaccine-row" do
				td class: "vaccine-name" do
					recomendacao_vacina.vacina!.descricao
				end
				td class: "dose-count text-center" do
					span class: "badge badge-info dose-badge" do
						recomendacao_vacina.qtde_doses_tomadas.to_s
					end
				end
				td class: "status-cell" do
					render_status_badge(recomendacao_vacina)
				end
				td class: "action-cell text-center" do
					link_to 'Cadastrar dose', new_vacina_dose_path(recomendacao_vacina.vacina), class: "btn btn-sm btn-success"
				end
			end
    end

		sig { params(recomendacao_vacina: User::Caderneta::RecomendacaoVacina).void }
		def render_status_badge(recomendacao_vacina)
			status = recomendacao_vacina.status_vacinal!
			idade_recomendada = get_idade_recomendada(recomendacao_vacina)
			
			case status
			when 'completo'
				span class: "badge badge-success status-completo" do
					"✅ Completo"
				end
			when 'disponivel'
				div do
					span class: "badge badge-warning status-disponivel mb-1" do
						"🕐 Disponível"
					end
					if idade_recomendada
						br
						small class: "text-muted idade-recomendada" do
							"👶 Recomendada: #{idade_recomendada}"
						end
					end
				end
			when 'aguardando'
				div do
					span class: "badge badge-secondary status-aguardando mb-1" do
						"⏳ Aguardando"
					end
					data_disponivel = recomendacao_vacina.quando_pode_tomar_proxima_dose&.strftime('%d/%m/%Y')
					if data_disponivel
						br
						small class: "text-muted data-disponivel" do
							"📅 Disponível em: #{data_disponivel}"
						end
					end
					if idade_recomendada
						br
						small class: "text-muted idade-recomendada" do
							"👶 Recomendada: #{idade_recomendada}"
						end
					end
				end
			else
				span class: "badge badge-light" do
					status.capitalize
				end
			end
		end

		sig { params(recomendacao_vacina: User::Caderneta::RecomendacaoVacina).returns(T.nilable(String)) }
		def get_idade_recomendada(recomendacao_vacina)
			# Busca a próxima dose recomendada para saber a idade
			dose_atual = recomendacao_vacina.dose_recomendada_atual
			return nil unless dose_atual
			
			# Busca a dose no calendário correspondente
			dose_calendario = DoseDoCalendario.find_by(vacina: recomendacao_vacina.vacina)
			return nil unless dose_calendario&.idade_recomendada
			
			idade_meses = dose_calendario.idade_recomendada.to_i
			
			if idade_meses == 0
				"Ao nascer"
			elsif idade_meses < 12
				"#{idade_meses} #{idade_meses == 1 ? 'mês' : 'meses'}"
			else
				anos = idade_meses / 12
				meses_restantes = idade_meses % 12
				
				if meses_restantes == 0
					"#{anos} #{anos == 1 ? 'ano' : 'anos'}"
				else
					"#{anos}a #{meses_restantes}m"
				end
			end
		end
  end
end
