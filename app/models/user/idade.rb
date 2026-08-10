class User
  module Idade
    def idade
      return 0.0 if data_nascimento.nil?

      ((Date.current - data_nascimento) / 365).to_f.truncate(2)
    end

    def meses_de_vida
      return 0 if data_nascimento.nil?

      hoje = Date.current
      meses = ((hoje.year - data_nascimento.year) * 12) + hoje.month - data_nascimento.month
      meses -= 1 if (data_nascimento >> meses) > hoje

      meses.negative? ? 0 : meses
    end

    def dias_desde_o_ultimo_mes_completo
      return 0 if data_nascimento.nil?

      (Date.current - (data_nascimento >> meses_de_vida)).to_i
    end

    def idade_formatada
      anos, meses = meses_de_vida.divmod(12)
      dias = dias_desde_o_ultimo_mes_completo

      partes = [
        pluralizar_trecho_idade(anos, 'ano', 'anos'),
        pluralizar_trecho_idade(meses, 'mês', 'meses'),
        pluralizar_trecho_idade(dias, 'dia', 'dias')
      ].reject { |parte| parte.start_with?('0 ') }

      return pluralizar_trecho_idade(dias, 'dia', 'dias') if partes.empty?

      partes.to_sentence(two_words_connector: ' e ', last_word_connector: ' e ')
    end

    private

    def pluralizar_trecho_idade(quantidade, singular, plural)
      "#{quantidade} #{quantidade == 1 ? singular : plural}"
    end
  end
end
