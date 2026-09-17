class CreateCadastrosClinicos < ActiveRecord::Migration[8.1]
  def change
    criar_especialidades
    criar_estabelecimentos
    criar_profissionais
  end

  private

  def criar_especialidades
    create_table :especialidades do |t|
      t.string :nome, null: false
      t.timestamps
    end
    add_index :especialidades, :nome, unique: true
  end

  def criar_estabelecimentos
    create_table :estabelecimentos do |t|
      t.string :nome, null: false
      t.timestamps
    end
    add_index :estabelecimentos, :nome, unique: true
  end

  def criar_profissionais
    create_table :profissionais do |t|
      t.string :nome, null: false
      t.references :especialidade, null: true, foreign_key: true
      t.timestamps
    end
    add_index :profissionais, %i[nome especialidade_id], unique: true, nulls_not_distinct: true
  end
end
