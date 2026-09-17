class CreateConsultas < ActiveRecord::Migration[8.1]
  def change
    create_table :consultas do |t|
      adicionar_referencias(t)
      adicionar_dados_clinicos(t)
      t.timestamps
    end

    add_index :consultas, %i[pessoa_id realizada_em]
  end

  private

  def adicionar_referencias(table)
    table.references :pessoa, null: false, index: false, foreign_key: { on_delete: :cascade }
    table.references :agendamento, null: true, foreign_key: true, index: { unique: true }
  end

  def adicionar_dados_clinicos(table)
    table.datetime :realizada_em, null: false
    table.string :motivo, null: false
    table.string :especialidade, :profissional_nome, :estabelecimento_nome
    table.text :resumo, :orientacoes
  end
end
