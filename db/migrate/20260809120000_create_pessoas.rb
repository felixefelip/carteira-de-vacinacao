class CreatePessoas < ActiveRecord::Migration[8.0]
  def change
    create_table :pessoas do |t|
      t.string :nome, null: false
      t.date :data_nascimento, null: false
      t.string :email
      t.boolean :titular, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :pessoas, :email, unique: true, where: 'email IS NOT NULL'

    add_index :pessoas, :user_id, unique: true, where: 'titular',
              name: 'index_pessoas_on_user_id_quando_titular'
  end
end
