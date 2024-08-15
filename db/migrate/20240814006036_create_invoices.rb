# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.string :cUF, null: false, limit: 2, comment: "cUF: Código da uF do emitente do Documento Fiscal."
      t.string :cNF, null: false, limit: 8, comment: "cNF: Código numérico que compõe a Chave de Acesso."
      t.string :mod, null: false, limit: 2, comment: "mod: Código do modelo do Documento Fiscal."
      t.string :serie, null: false, limit: 3, comment: "serie: Série do Documento Fiscal."
      t.string :nNF, null: false, limit: 9, comment: "nNF: Número do Documento Fiscal."
      t.string :tpNF, null: false, limit: 1, comment: "tpNF: Tipo de operação (0 = entrada, 1 = saída)."
      t.datetime :dhEmi, null: false, comment: "dhEmi: Data e hora de emissão do Documento Fiscal."
      t.datetime :processed_at

      t.references :user, null: false, foreign_key: true
      t.references :emit, null: false, foreign_key: { to_table: :invoice_entities }
      t.references :dest, null: false, foreign_key: { to_table: :invoice_entities }

      t.timestamps
    end
  end
end
