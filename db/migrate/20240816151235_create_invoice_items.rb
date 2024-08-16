# frozen_string_literal: true

class CreateInvoiceItems < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_items do |t|
      t.string :cProd, null: false, limit: 60, comment: "cProd: Código do Produto."
      t.string :cEAN, limit: 14, comment: "cEAN: Código de Barras do Produto."
      t.string :xProd, null: false, limit: 120, comment: "xProd: Descrição do Produto."
      t.string :nCM, null: false, limit: 8, comment: "NCM: Código NCM (Nomenclatura Comum do Mercosul)."
      t.string :cFOP, null: false, limit: 4, comment: "CFOP: Código Fiscal de Operações e Prestações."
      t.string :uCom, null: false, limit: 6, comment: "uCom: Unidade Comercial."
      t.decimal :qCom, null: false, precision: 15, scale: 4, comment: "qCom: Quantidade Comercializada."
      t.decimal :vUnCom, null: false, precision: 15, scale: 10, comment: "vUnCom: Valor Unitário de Comercialização."
      t.decimal :vProd, null: false, precision: 15, scale: 2, comment: "vProd: Valor Total Bruto dos Produtos ou Serviços."
      t.string :indTot, null: false, limit: 1, comment: "indTot: Indica se compõe o valor total da NF-e (0 = não, 1 = sim)."

      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
