class CreateDoses < ActiveRecord::Migration[6.1]
  def change
    create_table :doses do |t|
      t.string :tipo
      t.references :vacina, null: false, foreign_key: true

      t.timestamps
    end
  end
end
