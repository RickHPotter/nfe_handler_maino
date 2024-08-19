# frozen_string_literal: true

class CreateBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :batches do |t|
      t.string  :description, null: true
      t.integer :total_invoices, null: false
      t.integer :processed_invoices, null: false
      t.boolean :finished, null: false, default: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
