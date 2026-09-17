# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_17_040000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agendamentos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duracao_minutos"
    t.string "especialidade"
    t.string "estabelecimento_nome"
    t.datetime "inicio_em", null: false
    t.string "motivo", null: false
    t.text "observacoes"
    t.date "pago_em"
    t.bigint "pessoa_id", null: false
    t.string "profissional_nome"
    t.string "status", default: "agendado", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor", precision: 10, scale: 2
    t.index ["pessoa_id", "inicio_em"], name: "index_agendamentos_on_pessoa_id_and_inicio_em"
    t.index ["pessoa_id"], name: "index_agendamentos_on_pessoa_id"
  end

  create_table "cadernetas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "pessoa_id", null: false
    t.datetime "updated_at", null: false
    t.index ["pessoa_id"], name: "index_cadernetas_on_pessoa_id"
  end

  create_table "consultas", force: :cascade do |t|
    t.bigint "agendamento_id"
    t.datetime "created_at", null: false
    t.string "especialidade"
    t.string "estabelecimento_nome"
    t.string "motivo", null: false
    t.text "orientacoes"
    t.bigint "pessoa_id", null: false
    t.string "profissional_nome"
    t.datetime "realizada_em", null: false
    t.text "resumo"
    t.datetime "updated_at", null: false
    t.index ["agendamento_id"], name: "index_consultas_on_agendamento_id", unique: true
    t.index ["pessoa_id", "realizada_em"], name: "index_consultas_on_pessoa_id_and_realizada_em"
  end

  create_table "dose_do_calendarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.float "idade_recomendada"
    t.datetime "updated_at", null: false
    t.bigint "vacina_id"
    t.index ["vacina_id"], name: "index_dose_do_calendarios_on_vacina_id"
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "caderneta_id", null: false
    t.datetime "created_at", null: false
    t.date "data_vacinacao"
    t.bigint "fabricante_vacina_id", null: false
    t.string "local_codigo"
    t.string "lote_numero"
    t.string "tipo"
    t.datetime "updated_at", null: false
    t.string "vacinador_codigo"
    t.index ["caderneta_id"], name: "index_doses_on_caderneta_id"
    t.index ["fabricante_vacina_id"], name: "index_doses_on_fabricante_vacina_id"
  end

  create_table "fabricante_vacinas", force: :cascade do |t|
    t.bigint "caderneta_id"
    t.datetime "created_at", null: false
    t.string "descricao"
    t.datetime "updated_at", null: false
    t.bigint "vacina_id", null: false
    t.index ["caderneta_id"], name: "index_fabricante_vacinas_on_caderneta_id"
    t.index ["vacina_id"], name: "index_fabricante_vacinas_on_vacina_id"
  end

  create_table "fiscal_nota_fiscal_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "icms_aliquota"
    t.decimal "icms_valor"
    t.decimal "icms_valor_base_de_calculo"
    t.decimal "quantidade"
    t.datetime "updated_at", null: false
    t.decimal "valor_unitario"
  end

  create_table "pessoas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "data_nascimento", null: false
    t.string "email"
    t.string "nome", null: false
    t.boolean "titular", default: false, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["email"], name: "index_pessoas_on_email", unique: true, where: "(email IS NOT NULL)"
    t.index ["user_id"], name: "index_pessoas_on_user_id"
    t.index ["user_id"], name: "index_pessoas_on_user_id_quando_titular", unique: true, where: "titular"
  end

  create_table "recomendacao_vacinas", force: :cascade do |t|
    t.bigint "caderneta_id", null: false
    t.datetime "created_at", null: false
    t.integer "status_vacinal"
    t.datetime "updated_at", null: false
    t.bigint "vacina_id"
    t.index ["caderneta_id"], name: "index_recomendacao_vacinas_on_caderneta_id"
    t.index ["vacina_id"], name: "index_recomendacao_vacinas_on_vacina_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacinas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "descricao"
    t.integer "dias_de_intervalo", default: 0, null: false
    t.integer "ordem_no_calendario"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agendamentos", "pessoas", on_delete: :cascade
  add_foreign_key "cadernetas", "pessoas"
  add_foreign_key "consultas", "agendamentos"
  add_foreign_key "consultas", "pessoas", on_delete: :cascade
  add_foreign_key "dose_do_calendarios", "vacinas"
  add_foreign_key "doses", "fabricante_vacinas"
  add_foreign_key "fabricante_vacinas", "vacinas"
  add_foreign_key "pessoas", "users"
  add_foreign_key "recomendacao_vacinas", "vacinas"
end
