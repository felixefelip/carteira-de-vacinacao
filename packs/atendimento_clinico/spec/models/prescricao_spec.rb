require 'rails_helper'

RSpec.describe Prescricao, type: :model do
  describe 'associations' do
    it { should belong_to(:consulta).required }
    it { should belong_to(:medicamento).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:posologia) }
    it { should validate_presence_of(:inicio_em) }

    it 'não permite término anterior ao início', :aggregate_failures do
      prescricao = FactoryBot.build(
        :prescricao,
        inicio_em: Date.new(2026, 9, 10),
        termino_em: Date.new(2026, 9, 9),
      )

      expect(prescricao).to be_invalid
      expect(prescricao.errors[:termino_em]).to include('não pode ser anterior ao início do tratamento')
    end
  end

  describe '.da_pessoa' do
    it 'retorna apenas prescrições das consultas da pessoa' do
      pessoa = FactoryBot.create(:pessoa)
      prescricao = FactoryBot.create(:prescricao, consulta: FactoryBot.create(:consulta, pessoa:))
      FactoryBot.create(:prescricao)

      expect(described_class.da_pessoa(pessoa)).to contain_exactly(prescricao)
    end
  end

  describe '#situacao_em' do
    it 'é planejada quando ainda não começou' do
      prescricao = FactoryBot.build(:prescricao, inicio_em: Date.new(2026, 9, 18))

      expect(prescricao.situacao_em(Date.new(2026, 9, 17))).to eq(:planejada)
    end

    it 'está em uso enquanto não terminou' do
      prescricao = FactoryBot.build(:prescricao, inicio_em: Date.new(2026, 9, 1), termino_em: nil)

      expect(prescricao.situacao_em(Date.new(2026, 9, 17))).to eq(:em_uso)
    end

    it 'é encerrada depois da data de término' do
      prescricao = FactoryBot.build(
        :prescricao,
        inicio_em: Date.new(2026, 9, 1),
        termino_em: Date.new(2026, 9, 16),
      )

      expect(prescricao.situacao_em(Date.new(2026, 9, 17))).to eq(:encerrada)
    end
  end
end
