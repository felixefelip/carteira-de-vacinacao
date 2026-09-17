class CreatePrescricoes < ActiveRecord::Migration[8.1]
  def change
    create_table :prescricoes do |t|
      adicionar_referencias(t)
      adicionar_tratamento(t)
      t.timestamps
    end

    add_index :prescricoes, %i[consulta_id inicio_em]
  end

  private

  def adicionar_referencias(table)
    table.references :consulta, null: false, foreign_key: { on_delete: :cascade }
    table.references :medicamento, null: false, foreign_key: true
  end

  def adicionar_tratamento(table)
    table.string :posologia, null: false
    table.string :via_administracao
    table.date :inicio_em, null: false
    table.date :termino_em
    table.text :orientacoes
  end
end
