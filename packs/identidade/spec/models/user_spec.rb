require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:pessoas).dependent(:destroy) }
    it { should have_one(:pessoa_titular) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  describe 'pessoa titular', :aggregate_failures do
    it 'nasce junto com a conta, com o e-mail dela e com uma caderneta' do
      user = FactoryBot.create(:user, email: 'pai@example.com',
                                      pessoa_titular_attributes: { nome: 'Pai', data_nascimento: Date.new(1990, 5, 4) })

      expect(user.pessoa_titular).to have_attributes(nome: 'Pai', email: 'pai@example.com', titular: true)
      expect(user.pessoa_titular.caderneta).to be_present
      expect(user.pessoas).to eq([user.pessoa_titular])
    end

    it 'acompanha a troca de e-mail da conta' do
      user = FactoryBot.create(:user, email: 'antigo@example.com')

      user.update!(email: 'novo@example.com')

      expect(user.pessoa_titular.reload.email).to eq('novo@example.com')
    end

    it 'impede a conta de existir sem nome e sem data de nascimento' do
      user = FactoryBot.build(:user, pessoa_titular_attributes: { nome: '', data_nascimento: nil })

      expect(user).to be_invalid
      expect(user.errors.full_messages).to include('Nome não pode ficar em branco',
                                                   'Data de nascimento não pode ficar em branco')
    end
  end

  describe 'exclusão da conta' do
    it 'leva junto todas as pessoas e as cadernetas delas' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:pessoa, user:, nome: 'Filha')

      expect { user.destroy! }.to change(Pessoa, :count).by(-2).and change(Caderneta, :count).by(-2)
    end
  end
end
