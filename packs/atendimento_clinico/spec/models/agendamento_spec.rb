require 'rails_helper'

RSpec.describe Agendamento, type: :model do
  describe 'associations' do
    it { should belong_to(:pessoa).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:motivo) }
    it { should validate_presence_of(:inicio_em) }
    it { should validate_numericality_of(:duracao_minutos).only_integer.is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:valor).is_greater_than_or_equal_to(0).allow_nil }

    it 'aceita apenas as situações conhecidas', :aggregate_failures do
      agendamento = FactoryBot.build(:agendamento, status: 'desconhecido')

      expect(agendamento).to be_invalid
      expect(agendamento.errors[:status]).to be_present
    end
  end

  describe '#pago?' do
    it 'indica pagamento somente quando há uma data registrada', :aggregate_failures do
      expect(FactoryBot.build(:agendamento, pago_em: nil)).not_to be_pago
      expect(FactoryBot.build(:agendamento, pago_em: Date.current)).to be_pago
    end
  end
end
