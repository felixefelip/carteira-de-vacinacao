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

ActiveRecord::Schema[8.0].define(version: 2025_04_06_195617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "dose_do_calendarios", force: :cascade do |t|
    t.float "idade_recomendada"
    t.bigint "vacina_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vacina_id"], name: "index_dose_do_calendarios_on_vacina_id"
  end

  create_table "doses", force: :cascade do |t|
    t.string "tipo"
    t.date "data_vacinacao"
    t.string "lote_numero"
    t.string "vacinador_codigo"
    t.string "local_codigo"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fabricante_vacina_id", null: false
    t.index ["fabricante_vacina_id"], name: "index_doses_on_fabricante_vacina_id"
    t.index ["user_id"], name: "index_doses_on_user_id"
  end

  create_table "fabricante_vacinas", force: :cascade do |t|
    t.string "descricao"
    t.bigint "user_id"
    t.bigint "vacina_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fabricante_vacinas_on_user_id"
    t.index ["vacina_id"], name: "index_fabricante_vacinas_on_vacina_id"
  end

  create_table "fiscal_nota_fiscal_items", force: :cascade do |t|
    t.decimal "icms_aliquota"
    t.decimal "icms_valor"
    t.decimal "icms_valor_base_de_calculo"
    t.decimal "valor_unitario"
    t.decimal "quantidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recomendacao_vacinas", force: :cascade do |t|
    t.bigint "vacina_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status_vacinal"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_recomendacao_vacinas_on_user_id"
    t.index ["vacina_id"], name: "index_recomendacao_vacinas_on_vacina_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "data_nascimento"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacinas", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dias_de_intervalo", default: 0, null: false
    t.integer "ordem_no_calendario"
  end

  add_foreign_key "dose_do_calendarios", "vacinas"
  add_foreign_key "doses", "fabricante_vacinas"
  add_foreign_key "doses", "users"
  add_foreign_key "fabricante_vacinas", "users"
  add_foreign_key "fabricante_vacinas", "vacinas"
  add_foreign_key "recomendacao_vacinas", "users"
  add_foreign_key "recomendacao_vacinas", "vacinas"
end
