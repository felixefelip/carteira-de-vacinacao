class CreateFabricanteVacinas < ActiveRecord::Migration[6.1]
  def change
    create_table :fabricante_vacinas do |t|
      t.string :descricao
      t.references :user, foreign_key: true
      t.references :vacina, null: false, foreign_key: true

      t.timestamps
    end
  end
end
