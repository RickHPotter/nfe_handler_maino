# frozen_string_literal: true

class CreateInvoiceTotals < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_totals do |t|
      t.decimal :vBC, null: false, precision: 15, scale: 2, comment: "vBC: Valor da Base de Cálculo do ICMS."
      t.decimal :vICMS, null: false, precision: 15, scale: 2, default: 0.00, comment: "vICMS: Valor Total do ICMS."
      t.decimal :vIPI, null: false, precision: 15, scale: 2, default: 0.00, comment: "vIPI: Valor Total do IPI."
      t.decimal :vII, null: false, precision: 15, scale: 2, default: 0.00, comment: "vII: Valor Total do Imposto de Importação."
      t.decimal :vIOF, null: false, precision: 15, scale: 2, default: 0.00, comment: "vIOF: Valor Total do IOF."
      t.decimal :vPIS, null: false, precision: 15, scale: 2, default: 0.00, comment: "vPIS: Valor do PIS."
      t.decimal :vCOFINS, null: false, precision: 15, scale: 2, default: 0.00, comment: "vCOFINS: Valor do COFINS."
      t.decimal :vOutro, null: false, precision: 15, scale: 2, default: 0.00, comment: "vOutro: Outras Despesas Acessórias."
      t.decimal :vNF, null: false, precision: 15, scale: 2, comment: "vNF: Valor Total da Nota Fiscal."
      t.decimal :vTotTrib, null: false, precision: 15, scale: 2, default: 0.00, comment: "vTotTrib: Valor Total dos Tributos."

      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
