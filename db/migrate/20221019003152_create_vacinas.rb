class CreateVacinas < ActiveRecord::Migration[6.1]
  def change
    create_table :vacinas do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
