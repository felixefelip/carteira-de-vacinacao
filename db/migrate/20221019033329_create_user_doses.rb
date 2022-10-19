class CreateUserDoses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_doses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
