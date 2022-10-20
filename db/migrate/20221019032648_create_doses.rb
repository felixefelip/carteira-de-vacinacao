class CreateDoses < ActiveRecord::Migration[6.1]
  def change
    create_table :doses do |t|
      t.string :tipo
      t.date :data_vacinacao
      t.string :lote_numero
      t.string :vacinador_codigo
      t.string :local_codigo
      t.references :vacina, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
