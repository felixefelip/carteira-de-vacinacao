class CreateCaderneta < ActiveRecord::Migration[8.0]
  def change
    create_table :cadernetas do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # remove_column :recomendacao_vacinas, :user_id
    # remove_column :fabricante_vacinas, :user_id
    # remove_column :doses, :user_id
  end
end
