require 'rails_helper'

RSpec.describe Views::Sugestoes::Index do
  describe '#exibe_quando_pode_tomar_proxima_dose' do
    context 'quando não está com status aguardando' do
      it 'retorna uma string vazia' do
        recomendacao_vacina = FactoryBot.create(:recomendacao_vacina_record)
        user = recomendacao_vacina.user

        expect(described_class.new(user.caderneta!.recomendacao_vacinas).send(:exibe_quando_pode_tomar_proxima_dose, recomendacao_vacina)).to eq('')
      end
    end
  end
end
