# == Schema Information
#
# Table name: recomendacao_vacinas
#
#  id              :bigint           not null, primary key
#  status_vacinal  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recomendacao_id :bigint
#  vacina_id       :bigint
#
module RecomendacaoVacina
  class Record < ApplicationRecord
    self.table_name = "recomendacao_vacinas"

    belongs_to :recomendacao, class_name: "::Recomendacao::Record"
    belongs_to :vacina, class_name: "::Vacina::Record"

    enum status_vacinal: { aguardando: 0, disponivel: 1, completo: 2 } # , default: :aguardando

    before_validation :calcular_status_vacinal

    def qtde_doses_tomadas
      User::Doses::QtdePorVacina.call(recomendacao.user, vacina)
    end

    def calcular_status_vacinal
      self.status_vacinal = if tomou_todas_as_doses?
                              :completo
                            elsif pode_tomar_nova_dose?
                              :disponivel
                            else
                              :aguardando
                            end
    end

    def dose_recomendada_atual
      return if tomou_todas_as_doses?

      vacina.dose_do_calendarios[qtde_doses_tomadas]
    end

    def pode_tomar_nova_dose?
      return if tomou_todas_as_doses?

      tem_idade_para_tomar_a_dose? && !dose_atual_dentro_do_intervalo?
    end

    def tem_idade_para_tomar_a_dose?
      return true unless dose_recomendada_atual&.idade_recomendada

      recomendacao.user.idade >= dose_recomendada_atual.idade_recomendada
    end

    def dose_atual_dentro_do_intervalo?
      return false unless intervalo_para_proxima_dose_termina_em

      intervalo_para_proxima_dose_termina_em.past?
    end

    def intervalo_para_proxima_dose_termina_em
      return if recomendacao.user.doses.none?

      ultima_dose = recomendacao.user.doses.joins(:fabricante_vacina)
                                .where(fabricante_vacina: { vacina: vacina }).last

      return if ultima_dose.nil?

      ultima_dose.data_vacinacao&.+ vacina.dias_de_intervalo.to_i.days
    end

    def tomou_todas_as_doses?
      qtde_doses_tomadas >= vacina.dose_do_calendarios.count
    end

    def quando_pode_tomar_proxima_dose
      return intervalo_para_proxima_dose_termina_em if tem_idade_para_tomar_a_dose?

      meses_para_dose = ((dose_recomendada_atual.idade_recomendada - recomendacao.user.idade) / 0.1).to_i.months

      Date.current + meses_para_dose
    end

    def self.pode_tomar_hoje
      RecomendacaoVacina.where(status_vacinal: :aguardando).select do |rv|
        rv.quando_pode_tomar_proxima_dose == Date.current
      end
    end
  end
end
