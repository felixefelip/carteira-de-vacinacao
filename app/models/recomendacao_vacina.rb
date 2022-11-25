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
# Indexes
#
#  index_recomendacao_vacinas_on_recomendacao_id  (recomendacao_id)
#  index_recomendacao_vacinas_on_vacina_id        (vacina_id)
#
# Foreign Keys
#
#  fk_rails_...  (recomendacao_id => recomendacaos.id)
#  fk_rails_...  (vacina_id => vacinas.id)
#
class RecomendacaoVacina < ApplicationRecord
  belongs_to :recomendacao
  belongs_to :vacina

  enum status_vacinal: { aguardando: 0, disponivel: 1, completo: 2 } # , default: :aguardando

  before_validation :calcular_status_vacinal

  def qtde_doses_tomadas
    recomendacao.user.qtde_doses_por_vacina(vacina)
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

    recomendacao.user.doses.last.data_vacinacao&.+ vacina.dias_de_intervalo.to_i.days
  end

  def tomou_todas_as_doses?
    qtde_doses_tomadas >= vacina.dose_do_calendarios.count
  end

  def quando_pode_tomar_proxima_dose
    return intervalo_para_proxima_dose_termina_em if tem_idade_para_tomar_a_dose?

    # Precisa ajustar isso para a data de aniversário
    dose_recomendada_atual.idade_recomendada
  end
end
