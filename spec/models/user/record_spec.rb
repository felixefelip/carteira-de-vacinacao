require 'rails_helper'

RSpec.describe User::Record do
  describe 'associations' do
    it { should have_one(:recomendacao) }
    it { should have_many(:doses) }
    it { should have_many(:vacinas).through(:fabricante_vacinas) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:data_nascimento) }
    it { should validate_comparison_of(:data_nascimento).is_less_than(Date.current).with_message('não pode ser no futuro') }
  end
end
