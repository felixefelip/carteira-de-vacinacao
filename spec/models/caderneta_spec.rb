require 'rails_helper'

RSpec.describe User::Caderneta do
  describe 'associations' do
    it { should belong_to(:user).required }
    it { should have_many(:recomendacao_vacinas).dependent(:destroy) }
    it { should have_many(:doses).dependent(:destroy) }
    it { should have_many(:fabricante_vacinas).through(:doses) }
    it { should have_many(:vacinas).through(:fabricante_vacinas) }
  end
end
