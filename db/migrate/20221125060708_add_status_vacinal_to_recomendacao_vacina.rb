class AddStatusVacinalToRecomendacaoVacina < ActiveRecord::Migration[6.1]
  def change
    add_column :recomendacao_vacinas, :status_vacinal, :integer
  end
end
