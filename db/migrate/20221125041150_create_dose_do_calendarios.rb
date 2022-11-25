class CreateDoseDoCalendarios < ActiveRecord::Migration[6.1]
  def change
    create_table :dose_do_calendarios do |t|
      t.integer :idade_recomendada
      t.references :vacina, foreign_key: true

      t.timestamps
    end
  end
end
