class CreateRecomendacaoVacinas < ActiveRecord::Migration[6.1]
  def change
    create_table :recomendacao_vacinas do |t|
      t.references :recomendacao, foreign_key: true
      t.references :vacina, foreign_key: true

      t.timestamps
    end
  end
end
