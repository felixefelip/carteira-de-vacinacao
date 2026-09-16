require 'rails_helper'

RSpec.describe Vacina, type: :model do
  describe 'associations' do
    it { should have_many(:fabricante_vacinas).dependent(:destroy) }
    it { should have_many(:doses).through(:fabricante_vacinas) }
    it { should have_many(:recomendacao_vacinas).dependent(:destroy).class_name('Caderneta::RecomendacaoVacina') }
    it { should have_many(:dose_do_calendarios).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:descricao) }
    it { should validate_presence_of(:dias_de_intervalo) }
    it { should validate_uniqueness_of(:ordem_no_calendario) }
  end
end
