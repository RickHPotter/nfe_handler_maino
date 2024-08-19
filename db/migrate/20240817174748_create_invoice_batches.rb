# frozen_string_literal: true

class CreateInvoiceBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_batches do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :batch, null: false, foreign_key: true

      t.index %i[invoice_id batch_id], unique: true

      t.timestamps
    end
  end
end
