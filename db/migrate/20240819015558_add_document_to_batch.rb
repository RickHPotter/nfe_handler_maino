# frozen_string_literal: true

class AddDocumentToBatch < ActiveRecord::Migration[7.2]
  def change
    add_reference :batches, :document, null: true, foreign_key: true
  end
end
