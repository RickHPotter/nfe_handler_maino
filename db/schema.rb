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

ActiveRecord::Schema[7.2].define(version: 2024_08_17_174748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "batches", force: :cascade do |t|
    t.string "description"
    t.integer "total_invoices", null: false
    t.integer "processed_invoices", null: false
    t.boolean "finished", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_batches_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_addresses", force: :cascade do |t|
    t.string "xLgr", limit: 60, null: false, comment: "xLgr: Logradouro."
    t.string "nro", limit: 60, null: false, comment: "nro: Número do endereço."
    t.string "xCpl", limit: 60, comment: "xCpl: Complemento do endereço."
    t.string "xBairro", limit: 60, null: false, comment: "xBairro: Bairro."
    t.string "cMun", limit: 7, null: false, comment: "cMun: Código do município (utiliza código IBGE)."
    t.string "xMun", limit: 60, null: false, comment: "xMun: Nome do município."
    t.string "uF", limit: 2, null: false, comment: "UF: Sigla da Unidade Federativa."
    t.string "cEP", limit: 8, null: false, comment: "CEP: Código de Endereçamento Postal."
    t.string "cPais", limit: 4, null: false, comment: "cPais: Código do país (utiliza código BACEN)."
    t.string "xPais", limit: 60, null: false, comment: "xPais: Nome do país."
    t.string "fone", limit: 14, comment: "fone: Telefone (DDD + número)."
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_batches", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_invoice_batches_on_batch_id"
    t.index ["invoice_id", "batch_id"], name: "index_invoice_batches_on_invoice_id_and_batch_id", unique: true
    t.index ["invoice_id"], name: "index_invoice_batches_on_invoice_id"
  end

  create_table "invoice_entities", force: :cascade do |t|
    t.string "cNPJ", limit: 14, null: false, comment: "CNPJ: CNPJ do emitente ou destinatário."
    t.string "xNome", limit: 60, null: false, comment: "xNome: Razão Social ou nome do emitente ou destinatário."
    t.string "xFant", limit: 60, comment: "xFant: Nome fantasia do emitente."
    t.string "iE", limit: 14, comment: "IE: Inscrição Estadual do emitente ou destinatário."
    t.string "cRT", limit: 1, comment: "CRT: Código de Regime Tributário do emitente."
    t.string "indIEDest", limit: 1, comment: "indIEDest: Indicador da IE do destinatário (1 = Contribuinte, 2 = Isento, 9 = Não Contribuinte)."
    t.bigint "ender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ender_id"], name: "index_invoice_entities_on_ender_id"
  end

  create_table "invoice_item_totals", force: :cascade do |t|
    t.decimal "vICMS", precision: 15, scale: 2, default: "0.0", null: false, comment: "vICMS: Valor Total do ICMS."
    t.decimal "vIPI", precision: 15, scale: 2, default: "0.0", null: false, comment: "vIPI: Valor Total do IPI."
    t.decimal "vII", precision: 15, scale: 2, default: "0.0", null: false, comment: "vII: Valor Total do Imposto de Importação."
    t.decimal "vIOF", precision: 15, scale: 2, default: "0.0", null: false, comment: "vIOF: Valor Total do IOF."
    t.decimal "vTotTrib", precision: 15, scale: 2, default: "0.0", null: false, comment: "vTotTrib: Valor Total dos Tributos."
    t.bigint "invoice_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_item_id"], name: "index_invoice_item_totals_on_invoice_item_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.string "cProd", limit: 60, null: false, comment: "cProd: Código do Produto."
    t.string "cEAN", limit: 14, comment: "cEAN: Código de Barras do Produto."
    t.string "xProd", limit: 120, null: false, comment: "xProd: Descrição do Produto."
    t.string "nCM", limit: 8, null: false, comment: "NCM: Código NCM (Nomenclatura Comum do Mercosul)."
    t.string "cFOP", limit: 4, null: false, comment: "CFOP: Código Fiscal de Operações e Prestações."
    t.string "uCom", limit: 6, null: false, comment: "uCom: Unidade Comercial."
    t.decimal "qCom", precision: 15, scale: 4, null: false, comment: "qCom: Quantidade Comercializada."
    t.decimal "vUnCom", precision: 15, scale: 10, null: false, comment: "vUnCom: Valor Unitário de Comercialização."
    t.decimal "vProd", precision: 15, scale: 2, null: false, comment: "vProd: Valor Total Bruto dos Produtos ou Serviços."
    t.string "indTot", limit: 1, null: false, comment: "indTot: Indica se compõe o valor total da NF-e (0 = não, 1 = sim)."
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  end

  create_table "invoice_totals", force: :cascade do |t|
    t.decimal "vBC", precision: 15, scale: 2, null: false, comment: "vBC: Valor da Base de Cálculo do ICMS."
    t.decimal "vICMS", precision: 15, scale: 2, default: "0.0", null: false, comment: "vICMS: Valor Total do ICMS."
    t.decimal "vIPI", precision: 15, scale: 2, default: "0.0", null: false, comment: "vIPI: Valor Total do IPI."
    t.decimal "vII", precision: 15, scale: 2, default: "0.0", null: false, comment: "vII: Valor Total do Imposto de Importação."
    t.decimal "vIOF", precision: 15, scale: 2, default: "0.0", null: false, comment: "vIOF: Valor Total do IOF."
    t.decimal "vPIS", precision: 15, scale: 2, default: "0.0", null: false, comment: "vPIS: Valor do PIS."
    t.decimal "vCOFINS", precision: 15, scale: 2, default: "0.0", null: false, comment: "vCOFINS: Valor do COFINS."
    t.decimal "vOutro", precision: 15, scale: 2, default: "0.0", null: false, comment: "vOutro: Outras Despesas Acessórias."
    t.decimal "vNF", precision: 15, scale: 2, null: false, comment: "vNF: Valor Total da Nota Fiscal."
    t.decimal "vTotTrib", precision: 15, scale: 2, default: "0.0", null: false, comment: "vTotTrib: Valor Total dos Tributos."
    t.bigint "invoice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_totals_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "cUF", limit: 2, null: false, comment: "cUF: Código da uF do emitente do Documento Fiscal."
    t.string "cNF", limit: 8, null: false, comment: "cNF: Código numérico que compõe a Chave de Acesso."
    t.string "mod", limit: 2, null: false, comment: "mod: Código do modelo do Documento Fiscal."
    t.string "serie", limit: 3, null: false, comment: "serie: Série do Documento Fiscal."
    t.string "nNF", limit: 9, null: false, comment: "nNF: Número do Documento Fiscal."
    t.string "tpNF", limit: 1, null: false, comment: "tpNF: Tipo de operação (0 = entrada, 1 = saída)."
    t.datetime "dhEmi", null: false, comment: "dhEmi: Data e hora de emissão do Documento Fiscal."
    t.datetime "processed_at"
    t.bigint "user_id", null: false
    t.bigint "emit_id", null: false
    t.bigint "dest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "document_id", null: false
    t.index ["dest_id"], name: "index_invoices_on_dest_id"
    t.index ["document_id"], name: "index_invoices_on_document_id"
    t.index ["emit_id"], name: "index_invoices_on_emit_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.string "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "batches", "users"
  add_foreign_key "invoice_batches", "batches"
  add_foreign_key "invoice_batches", "invoices"
  add_foreign_key "invoice_entities", "entity_addresses", column: "ender_id"
  add_foreign_key "invoice_item_totals", "invoice_items"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_totals", "invoices"
  add_foreign_key "invoices", "documents"
  add_foreign_key "invoices", "invoice_entities", column: "dest_id"
  add_foreign_key "invoices", "invoice_entities", column: "emit_id"
  add_foreign_key "invoices", "users"
end
