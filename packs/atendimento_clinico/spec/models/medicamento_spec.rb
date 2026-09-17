require 'rails_helper'

RSpec.describe Medicamento, type: :model do
  describe 'associations' do
    it { should have_many(:prescricoes).dependent(:restrict_with_exception) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
  end

  describe '#identificacao' do
    it 'reúne somente os dados disponíveis' do
      medicamento = described_class.new(nome: 'Losartana', apresentacao: 'Comprimido 50 mg')

      expect(medicamento.identificacao).to eq('Losartana · Comprimido 50 mg')
    end
  end
end
