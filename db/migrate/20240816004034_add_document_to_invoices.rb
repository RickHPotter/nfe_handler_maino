# frozen_string_literal: true

class AddDocumentToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_reference :invoices, :document, null: false, foreign_key: true
  end
end
