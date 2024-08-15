# frozen_string_literal: true

class CreateInvoiceEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_entities do |t|
      t.string :cNPJ, null: false, limit: 14, comment: "CNPJ: CNPJ do emitente ou destinatário."
      t.string :xNome, null: false, limit: 60, comment: "xNome: Razão Social ou nome do emitente ou destinatário."
      t.string :xFant, limit: 60, comment: "xFant: Nome fantasia do emitente."
      t.string :iE, limit: 14, comment: "IE: Inscrição Estadual do emitente ou destinatário."
      t.string :cRT, limit: 1, comment: "CRT: Código de Regime Tributário do emitente."
      t.string :indIEDest, limit: 1, comment: "indIEDest: Indicador da IE do destinatário (1 = Contribuinte, 2 = Isento, 9 = Não Contribuinte)."
      t.references :ender, null: false, foreign_key: { to_table: :entity_addresses }

      t.timestamps
    end
  end
end
