require "rails_helper"

RSpec.describe SugestoesHelper, type: :helper do
  describe "#exibe_quando_pode_tomar_proxima_dose" do
    context "quando não está com status aguardando" do
      it "retorna nil" do
        recomendacao_vacina = RecomendacaoVacina::Record.new

        expect(helper.exibe_quando_pode_tomar_proxima_dose(recomendacao_vacina)).to be_nil
      end
    end
  end
end
