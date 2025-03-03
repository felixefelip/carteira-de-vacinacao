# typed: true

module RecomendacaoVacina
  class Entity
    extend T::Sig

    sig { returns(Integer) }
    attr_accessor :id

    sig { returns(Recomendacao::Record) }
    attr_accessor :recomendacao

    sig { returns(Vacina::Record) }
    attr_accessor :vacina

    sig { returns(Symbol) }
    attr_accessor :status_vacinal

    private :id=, :recomendacao=, :vacina=, :user=, :status_vacinal=

    sig do
      params(id: Integer, recomendacao: Recomendacao::Record, vacina: Vacina::Record,
             status_vacinal: T.nilable(Symbol)).void
    end
    def initialize(id:, recomendacao:, vacina:, status_vacinal:)
      self.id = id
      self.recomendacao = recomendacao
      self.vacina = vacina
      self.status_vacinal = status_vacinal || calcular_status_vacinal
    end

    # def teste
    #   RecomendacaoVacina::Entity.new(id: 1, recomendacao: nil, vacina: "aa", status_vacinal: 1)
    # end

    sig { returns(Symbol) }
    def calcular_status_vacinal
      if tomou_todas_as_doses?
        :completo
      elsif pode_tomar_nova_dose?
        :disponivel
      else
        :aguardando
      end
    end

    sig { returns(Integer) }
    def qtde_doses_tomadas
      ::User::Doses.new(user).qtde_por_vacina(vacina)
    end

    sig { returns(User::Record) }
    def user
      recomendacao.user || raise('Recomendacao sem usuário')
    end

    sig { returns(T::Boolean) }
    def tomou_todas_as_doses?
      qtde_doses_tomadas >= vacina.dose_do_calendarios.count
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

      user.idade >= idade_recomendada_para_proxima_dose
    end

    sig { returns(T::Boolean) }
    def dose_atual_dentro_do_intervalo_de_espera?
      return false unless (intervalo_para_proxima_dose_termina_em = self.intervalo_para_proxima_dose_termina_em)

      intervalo_para_proxima_dose_termina_em > Date.current
    end

    sig { returns(T.nilable(::DoseDoCalendario::Record)) }
    def dose_recomendada_atual
      return if tomou_todas_as_doses?

      vacina.dose_do_calendarios[qtde_doses_tomadas]
    end

    sig { returns(T.nilable(::Date)) }
    def intervalo_para_proxima_dose_termina_em
      return unless (ultima_dose_tomada = self.ultima_dose_tomada)
      return unless (data_vacinacao_ultima_dose = ultima_dose_tomada.data_vacinacao)

      data_vacinacao_ultima_dose + vacina.dias_de_intervalo.to_i.days
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
      user.doses.joins(:fabricante_vacina)
        .where(fabricante_vacina: { vacina: }).last
    end
  end
end
