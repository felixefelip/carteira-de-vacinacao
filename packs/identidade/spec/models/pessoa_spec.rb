require 'rails_helper'

RSpec.describe Pessoa, type: :model do
  describe 'associations' do
    it { should belong_to(:user).required }
    it { should have_one(:caderneta).dependent(:destroy) }
  end

  describe 'validations' do
    subject(:pessoa) { FactoryBot.create(:pessoa) }

    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:data_nascimento) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it 'não aceita data de nascimento no futuro' do
      expect(pessoa).to validate_comparison_of(:data_nascimento)
        .is_less_than(Date.current).with_message('não pode ser no futuro')
    end
  end

  describe 'caderneta' do
    it 'é criada junto com a pessoa, já com o calendário de vacinas', :aggregate_failures do
      CadastraVacinasPadrao.call

      pessoa = FactoryBot.create(:pessoa)

      expect(pessoa.caderneta).to be_present
      expect(pessoa.caderneta.recomendacao_vacinas.count).to eq(17)
    end
  end

  describe 'e-mail', :aggregate_failures do
    it 'é opcional e guardado em minúsculas e sem espaços' do
      pessoa = FactoryBot.create(:pessoa, email: '  Filha@Example.com ')

      expect(pessoa.email).to eq('filha@example.com')
      expect(FactoryBot.create(:pessoa, email: '').email).to be_nil
    end

    it 'não pode ser o de uma conta que já existe' do
      FactoryBot.create(:user, email: 'ocupado@example.com')

      pessoa = FactoryBot.build(:pessoa, email: 'ocupado@example.com')

      expect(pessoa).to be_invalid
      expect(pessoa.errors.full_messages).to include('E-mail já pertence a outra conta')
    end
  end
end
