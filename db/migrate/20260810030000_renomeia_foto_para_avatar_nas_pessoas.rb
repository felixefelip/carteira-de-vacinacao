class RenomeiaFotoParaAvatarNasPessoas < ActiveRecord::Migration[8.0]
  def up
    renomeia_anexo('foto', 'avatar')
  end

  def down
    renomeia_anexo('avatar', 'foto')
  end

  private

  def renomeia_anexo(de, para)
    execute <<~SQL.squish
      UPDATE active_storage_attachments
         SET name = #{connection.quote(para)}
       WHERE record_type = 'Pessoa'
         AND name = #{connection.quote(de)}
    SQL
  end
end
