require 'rails_helper'

RSpec.describe User::Caderneta::RecomendacaoVacina, :aggregate_failures do
  describe 'associations' do
    it { should have_one(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:status_vacinal).with_values(aguardando: 0, disponivel: 1, completo: 2) }
  end

  describe 'dose_atual_dentro_do_intervalo_de_espera?' do
    context 'quando a dose atual está dentro do intervalo de espera' do
      it 'retorna true' do
        travel_to '2025-10-01'
        CadastraVacinasPadrao.call

        user = FactoryBot.create(:user, data_nascimento: 5.months.ago)

        expect(user.caderneta!.recomendacao_vacinas.count).to eq(3)

        recomendacao_vacina = user.caderneta!.recomendacao_vacinas.detect do |recomendacao_vacina_busca|
          recomendacao_vacina_busca.vacina!.descricao == 'Poliomielite 1,2,3 (VIP - inativada)'
        end

        expect(recomendacao_vacina.pode_tomar_nova_dose?).to(be(true))
        expect(recomendacao_vacina.dose_atual_dentro_do_intervalo_de_espera?).to(be(false))
        expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to eq(nil)
        expect(recomendacao_vacina.status_vacinal).to eq('disponivel')

        Dose.create!(
          caderneta: user.caderneta!,
          data_vacinacao: Date.current,
          fabricante_vacina: recomendacao_vacina.vacina!.fabricante_vacinas.first!,
        )

        expect(recomendacao_vacina.pode_tomar_nova_dose?).to(be(false))
        expect(recomendacao_vacina.dose_atual_dentro_do_intervalo_de_espera?).to(be(true))
        expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to eq(Date.current + recomendacao_vacina.vacina!.dias_de_intervalo.days)
        expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to eq(Date.current + 30.days)
        expect(recomendacao_vacina.status_vacinal).to eq('aguardando')

        travel_to '2025-11-03'
        expect(recomendacao_vacina.pode_tomar_nova_dose?).to(be(true))
        expect(recomendacao_vacina.dose_atual_dentro_do_intervalo_de_espera?).to(be(false))

        # TODO: precisa fazer um worker para rodar todo dia atualizando o status_vacinal de todas as recomendacoes_vacinas
        recomendacao_vacina.calcular_status_vacinal
        expect(recomendacao_vacina.status_vacinal).to eq('disponivel')

        Dose.create!(
          caderneta: user.caderneta!,
          data_vacinacao: Date.current,
          fabricante_vacina: recomendacao_vacina.vacina!.fabricante_vacinas.first!,
        )

        expect(recomendacao_vacina.pode_tomar_nova_dose?).to(be(false))
        expect(recomendacao_vacina.dose_atual_dentro_do_intervalo_de_espera?).to(be(true))
        # expect(recomendacao_vacina.quando_pode_tomar_proxima_dose).to eq(Date.current + recomendacao_vacina.vacina!.dias_de_intervalo.days)
        expect(recomendacao_vacina.status_vacinal).to eq('aguardando')
      end
    end
  end
end
