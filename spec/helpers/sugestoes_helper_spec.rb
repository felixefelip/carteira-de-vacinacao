require 'rails_helper'

RSpec.describe SugestoesHelper do
  describe '#exibe_quando_pode_tomar_proxima_dose' do
    context 'quando não está com status aguardando' do
      it 'retorna uma string vazia' do
        recomendacao_vacina = RecomendacaoVacina::Record.new

        expect(helper.exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)).to eq('')
      end
    end
  end
end
