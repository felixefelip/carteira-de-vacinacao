require 'rails_helper'

RSpec.describe Profissional, type: :model do
  describe 'associations' do
    it { should belong_to(:especialidade).optional }
    it { should have_many(:agendamentos).dependent(:restrict_with_exception) }
    it { should have_many(:consultas).dependent(:restrict_with_exception) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:profissional) }

    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).scoped_to(:especialidade_id) }
  end

  describe '#identificacao' do
    it 'inclui a especialidade quando vinculada' do
      profissional = FactoryBot.build(:profissional, nome: 'Dra. Ana')
      profissional.especialidade.nome = 'Cardiologia'

      expect(profissional.identificacao).to eq('Dra. Ana · Cardiologia')
    end
  end
end
