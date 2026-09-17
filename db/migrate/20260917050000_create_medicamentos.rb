class CreateMedicamentos < ActiveRecord::Migration[8.1]
  def change
    create_table :medicamentos do |t|
      t.string :nome, null: false
      t.string :principio_ativo
      t.string :apresentacao

      t.timestamps
    end

    add_index :medicamentos, :nome
  end
end
