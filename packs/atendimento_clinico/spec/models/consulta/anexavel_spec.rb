require 'rails_helper'

RSpec.describe Consulta::Anexavel do
  describe 'anexos', :aggregate_failures do
    it 'aceita imagens e PDFs' do
      consulta = FactoryBot.build(:consulta)
      consulta.anexos.attach(
        { io: StringIO.new('imagem'), filename: 'imagem.png', content_type: 'image/png' },
        { io: StringIO.new('%PDF-1.4'), filename: 'documento.pdf', content_type: 'application/pdf' },
      )

      expect(consulta).to be_valid
      expect(consulta.anexos.size).to eq(2)
    end

    it 'recusa outros tipos de arquivo' do
      consulta = FactoryBot.build(:consulta)
      consulta.anexos.attach(io: StringIO.new('texto'), filename: 'texto.txt', content_type: 'text/plain')

      expect(consulta).to be_invalid
      expect(consulta.errors.full_messages).to include(
        'Anexos texto.txt precisa ser PDF, PNG, JPEG ou WEBP',
      )
    end

    it 'recusa arquivos acima do tamanho máximo' do
      consulta = FactoryBot.build(:consulta)
      conteudo = StringIO.new('x' * (Consulta::Anexavel::TAMANHO_MAXIMO + 1))
      consulta.anexos.attach(io: conteudo, filename: 'grande.pdf', content_type: 'application/pdf')

      expect(consulta).to be_invalid
      expect(consulta.errors.full_messages).to include(
        'Anexos grande.pdf precisa ter no máximo 10 MB',
      )
    end
  end
end
