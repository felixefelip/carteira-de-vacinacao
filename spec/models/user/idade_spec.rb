require 'rails_helper'

describe User::Idade do
  describe '#idade & #idade_formatada', :aggregate_failures do
    context 'quando a data de nascimento é 01/01/2000' do
      it 'retorna 22' do
        travel_to Time.zone.local(2022, 1, 1) do
          user = User.new(data_nascimento: '01/01/2000')
          expect(user.idade).to eq(22.01)
          expect(user.idade_formatada).to eq('22 anos')
        end
      end
    end

    context 'quando tem mais de 10 meses e menos de 1 ano' do
      it 'retorna 1' do
        travel_to Date.new(2022, 1, 1) do
          user = User.new(data_nascimento: Date.new(2021, 11, 11))
          expect(user.idade).to eq(0.13)
          expect(user.idade_formatada).to eq('1 mês')
        end
      end
    end

    context 'quando tem menos de 10 meses e mais de 2 meses' do
      it 'retorna 4' do
        travel_to Date.new(2022, 1, 1) do
          user = User.new(data_nascimento: Date.new(2021, 7, 11))
          expect(user.idade).to eq(0.47)
          expect(user.idade_formatada).to eq('4 meses')
        end
      end
    end

    context 'quando tem menos de 11 meses' do
      it 'retorna 4' do
        travel_to Date.new(2022, 11, 1) do
          user = User.new(data_nascimento: Date.new(2021, 1, 1))
          expect(user.idade).to eq(1.1)
          expect(user.idade_formatada).to eq('11 meses')
        end
      end
    end
  end
end
