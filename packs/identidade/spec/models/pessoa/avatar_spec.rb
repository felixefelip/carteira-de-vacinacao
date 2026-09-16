require 'rails_helper'

RSpec.describe Pessoa::Avatar do
  describe 'avatar_precisa_ser_uma_imagem_pequena', :aggregate_failures do
    it 'recusa arquivo que não é imagem' do
      pessoa = FactoryBot.build(:pessoa)
      pessoa.avatar.attach(io: StringIO.new('não sou imagem'), filename: 'texto.txt', content_type: 'text/plain')

      expect(pessoa).to be_invalid
      expect(pessoa.errors.full_messages).to include('Foto precisa ser PNG, JPEG ou WEBP')
    end

    it 'recusa imagem acima do tamanho máximo' do
      pessoa = FactoryBot.build(:pessoa)
      conteudo = StringIO.new('x' * (Pessoa::Avatar::TAMANHO_MAXIMO + 1))
      pessoa.avatar.attach(io: conteudo, filename: 'grande.png', content_type: 'image/png')

      expect(pessoa).to be_invalid
      expect(pessoa.errors.full_messages).to include('Foto precisa ter no máximo 5 MB')
    end

    it 'aceita imagem dentro do limite' do
      pessoa = FactoryBot.build(:pessoa)
      pessoa.avatar.attach(io: StringIO.new('imagem'), filename: 'foto.png', content_type: 'image/png')

      expect(pessoa).to be_valid
    end
  end

  describe '#iniciais' do
    it 'usa as duas primeiras palavras do nome' do
      expect(FactoryBot.build(:pessoa, nome: 'ana clara souza').iniciais).to eq('AC')
    end
  end
end
