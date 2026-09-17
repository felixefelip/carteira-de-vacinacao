require 'rails_helper'

RSpec.describe Estabelecimento, type: :model do
  describe 'associations' do
    it { should have_many(:agendamentos).dependent(:restrict_with_exception) }
    it { should have_many(:consultas).dependent(:restrict_with_exception) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:estabelecimento) }

    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome) }
  end
end
