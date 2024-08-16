# frozen_string_literal: true

class CreateInvoiceItemTotals < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_item_totals do |t|
      t.decimal :vICMS, null: false, precision: 15, scale: 2, default: 0.00, comment: "vICMS: Valor Total do ICMS."
      t.decimal :vIPI, null: false, precision: 15, scale: 2, default: 0.00, comment: "vIPI: Valor Total do IPI."
      t.decimal :vII, null: false, precision: 15, scale: 2, default: 0.00, comment: "vII: Valor Total do Imposto de Importação."
      t.decimal :vIOF, null: false, precision: 15, scale: 2, default: 0.00, comment: "vIOF: Valor Total do IOF."
      t.decimal :vTotTrib, null: false, precision: 15, scale: 2, default: 0.00, comment: "vTotTrib: Valor Total dos Tributos."

      t.references :invoice_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
