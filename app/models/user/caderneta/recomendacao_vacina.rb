# typed: true

# == Schema Information
#
# Table name: recomendacao_vacinas
#
#  id             :bigint           not null, primary key
#  status_vacinal :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  caderneta_id   :bigint           not null
#  vacina_id      :bigint
#
class User::Caderneta::RecomendacaoVacina < ApplicationRecord
  extend T::Sig

  self.table_name = 'recomendacao_vacinas'

  belongs_to :caderneta, class_name: 'User::Caderneta'
  belongs_to :vacina

  has_one :user, through: :caderneta

  enum :status_vacinal, [:aguardando, :disponivel, :completo]

  before_save :calcular_status_vacinal

  #: -> User::Caderneta
  def caderneta!
    T.must(caderneta)
  end

  #: -> Vacina
  def vacina!
    T.must(vacina)
  end

  #: -> User
  def user!
    T.must(user)
  end

  #: -> Float
  def user_idade
    user!.idade
  end

  #: -> Integer
  def qtde_doses_tomadas
    caderneta!.qtde_por_vacina(vacina!)
  end

  #: -> void
  def calcular_status_vacinal
    self.status_vacinal = if tomou_todas_as_doses?
                            :completo
                          elsif pode_tomar_nova_dose?
                            :disponivel
                          else
                            :aguardando
                          end
  end

  #: -> DoseDoCalendario?
  def dose_recomendada_atual
    return if tomou_todas_as_doses?

    vacina!.dose_do_calendarios[qtde_doses_tomadas]
  end

  #: -> bool
  def pode_tomar_nova_dose?
    return false if tomou_todas_as_doses?

    tem_idade_para_tomar_a_nova_dose? && !dose_atual_dentro_do_intervalo_de_espera?
  end

  #: -> bool
  def tem_idade_para_tomar_a_nova_dose?
    idade_recomendada_para_proxima_dose = dose_recomendada_atual&.idade_recomendada
    return true if idade_recomendada_para_proxima_dose.nil?

    user_idade >= idade_recomendada_para_proxima_dose
  end

  #: -> bool
  def dose_atual_dentro_do_intervalo_de_espera?
    return false unless (intervalo_para_proxima_dose_termina_em = self.intervalo_para_proxima_dose_termina_em)

    intervalo_para_proxima_dose_termina_em > Date.current
  end

  #: -> Date?
  def intervalo_para_proxima_dose_termina_em
    return unless (data_vacinacao_ultima_dose = ultima_dose_tomada&.data_vacinacao)
    return if vacina!.dias_de_intervalo.zero?

    data_vacinacao_ultima_dose + vacina!.dias_de_intervalo.days
  end

  #: -> bool
  def tomou_todas_as_doses?
    return false if (vacina_doses_do_calendario_count = vacina!.dose_do_calendarios.count).zero?

    qtde_doses_tomadas >= vacina_doses_do_calendario_count
  end

  #: -> Date?
  def quando_pode_tomar_proxima_dose
    return intervalo_para_proxima_dose_termina_em if tem_idade_para_tomar_a_nova_dose?
    return unless (idade_dose_recomendada_atual = dose_recomendada_atual&.idade_recomendada)

    meses_para_dose = ((idade_dose_recomendada_atual - user_idade) / 0.1).to_i.months

    Date.current + meses_para_dose
  end

  #: -> Array[User::Caderneta::RecomendacaoVacina]
  def self.recomendacoes_vacina_para_tomar_nova_dose_hoje
    T.cast(
      User::Caderneta::RecomendacaoVacina.where(status_vacinal: :aguardando).select do |recomendacao_vacina|
        recomendacao_vacina.quando_pode_tomar_proxima_dose == Date.current
      end,
      T::Array[User::Caderneta::RecomendacaoVacina],
    )
  end

  private

  #: -> Dose?
  def ultima_dose_tomada
    caderneta!.doses.joins(:fabricante_vacina)
      .where(fabricante_vacina: { vacina: vacina! }).last
  end
end
