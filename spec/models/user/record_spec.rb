require 'rails_helper'

RSpec.describe User::Record, type: :model do
  describe 'associations' do
    it { should have_one(:recomendacao) }
    it { should have_many(:doses) }
    it { should have_many(:vacinas).through(:fabricante_vacinas) }
  end
end
