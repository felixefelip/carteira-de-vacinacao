class RemoveDataNascimentoFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :data_nascimento, :date
  end
end
