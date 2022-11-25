class AddCamposDeRecomendacaoVacinalNaVacina < ActiveRecord::Migration[6.1]
  def change
    add_column :vacinas, :dias_de_intervalo, :integer
  end
end
