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
  # typed: true
  class Record < ApplicationRecord
    extend T::Sig

    self.table_name = 'recomendacao_vacinas'

    belongs_to :recomendacao, class_name: '::Recomendacao::Record'
    belongs_to :vacina, class_name: '::Vacina::Record'

    enum :status_vacinal, [:aguardando, :disponivel, :completo]

    before_save :calcular_status_vacinal

    sig { returns(Integer) }
    def qtde_doses_tomadas
      return 0 unless (user = recomendacao&.user)
      return 0 unless (vacina = self.vacina)

      ::User::Doses.new(user).qtde_por_vacina(vacina)
    end

    sig { void }
    def calcular_status_vacinal
      self.status_vacinal = if tomou_todas_as_doses?
                              :completo
                            elsif pode_tomar_nova_dose?
                              :disponivel
                            else
                              :aguardando
                            end
    end

    sig { returns(T.nilable(::DoseDoCalendario::Record)) }
    def dose_recomendada_atual
      return if tomou_todas_as_doses?
      return unless (vacina_dose_do_calendarios = vacina&.dose_do_calendarios)

      vacina_dose_do_calendarios[qtde_doses_tomadas]
    end

    sig { returns(T::Boolean) }
    def pode_tomar_nova_dose?
      return false if tomou_todas_as_doses?

      tem_idade_para_tomar_a_nova_dose? && !dose_atual_dentro_do_intervalo_de_espera?
    end

    sig { returns(T::Boolean) }
    def tem_idade_para_tomar_a_nova_dose?
      idade_recomendada_para_proxima_dose = dose_recomendada_atual&.idade_recomendada
      return true if idade_recomendada_para_proxima_dose.nil?
      return false unless (user_idade = recomendacao&.user&.idade)

      user_idade >= idade_recomendada_para_proxima_dose
    end

    sig { returns(T::Boolean) }
    def dose_atual_dentro_do_intervalo_de_espera?
      return false unless (intervalo_para_proxima_dose_termina_em = self.intervalo_para_proxima_dose_termina_em)

      intervalo_para_proxima_dose_termina_em > Date.current
    end

    sig { returns(T.nilable(::Date)) }
    def intervalo_para_proxima_dose_termina_em
      return unless (ultima_dose_tomada = self.ultima_dose_tomada)
      return unless (data_vacinacao_ultima_dose = ultima_dose_tomada.data_vacinacao)
      return unless (vacina_dias_de_intervalo = vacina&.dias_de_intervalo)

      data_vacinacao_ultima_dose + vacina_dias_de_intervalo.to_i.days
    end

    sig { returns(T::Boolean) }
    def tomou_todas_as_doses?
      return false unless (vacina_doses_do_calendario = vacina&.dose_do_calendarios)

      qtde_doses_tomadas >= vacina_doses_do_calendario.count
    end

    sig { returns(T.nilable(::Date)) }
    def quando_pode_tomar_proxima_dose
      return intervalo_para_proxima_dose_termina_em if tem_idade_para_tomar_a_nova_dose?
      return nil unless (idade_dose_recomendada_atual = dose_recomendada_atual&.idade_recomendada)
      return nil unless (user_idade = recomendacao&.user&.idade)

      meses_para_dose = ((idade_dose_recomendada_atual - user_idade) / 0.1).to_i.months

      Date.current + meses_para_dose
    end

    sig { returns(T::Array[RecomendacaoVacina::Record]) }
    def self.recomendacoes_vacina_para_tomar_nova_dose_hoje
      RecomendacaoVacina::Record.where(status_vacinal: :aguardando).select do |recomendacao_vacina|
        recomendacao_vacina.quando_pode_tomar_proxima_dose == Date.current
      end.to_a
    end

    private

    sig { returns(T.nilable(::Dose::Record)) }
    def ultima_dose_tomada
      return unless (user = recomendacao&.user)

      user.doses.joins(:fabricante_vacina)
        .where(fabricante_vacina: { vacina: vacina }).last
    end
  end
end
