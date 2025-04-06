class DropRecomendacao < ActiveRecord::Migration[8.0]
  def change
    remove_column :recomendacao_vacinas, :recomendacao_id, :bigint
    add_reference :recomendacao_vacinas, :user
    add_foreign_key :recomendacao_vacinas, :users
    drop_table :recomendacaos
  end
end
