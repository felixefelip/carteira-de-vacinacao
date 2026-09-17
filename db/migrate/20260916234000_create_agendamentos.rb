class CreateAgendamentos < ActiveRecord::Migration[8.1]
  def change
    create_table :agendamentos do |t|
      t.references :pessoa, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :inicio_em, null: false
      t.integer :duracao_minutos
      t.string :motivo, null: false
      t.string :especialidade
      t.string :profissional_nome
      t.string :estabelecimento_nome
      t.text :observacoes
      t.string :status, null: false, default: 'agendado'
      t.decimal :valor, precision: 10, scale: 2
      t.date :pago_em

      t.timestamps
    end

    add_index :agendamentos, %i[pessoa_id inicio_em]
  end
end
