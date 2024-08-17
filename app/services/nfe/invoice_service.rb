# frozen_string_literal: true

module Nfe
  class InvoiceService
    attr_reader :invoice

    def initialize(extracted_nfe, current_user, document_id)
      @nfe = extracted_nfe
      @current_user = current_user
      @document = Document.find(document_id)

      @nfe_data = extracted_nfe.extract_invoice_data
      @nfe_entities = { emit: extracted_nfe.extract_invoice_entity(:emit), dest: extracted_nfe.extract_invoice_entity(:dest) }
      @nfe_addresses = { emit: extracted_nfe.extract_invoice_address(:emit), dest: extracted_nfe.extract_invoice_address(:dest) }
      @nfe_totals = extracted_nfe.extract_invoice_totals
      # @nfe_items = extracted_nfe.extract_invoice_items
    end

    def run
      ActiveRecord::Base.transaction do
        @invoice = Invoice.create!(invoice_attributes)
      end
    end

    private

    def invoice_attributes
      {
        **@nfe_data,
        user_id: @current_user.id, document_id: @document.id,
        emit_attributes: build_invoice_entities(:emit),
        dest_attributes: build_invoice_entities(:dest),
        processed_at: DateTime.current,
        invoice_total_attributes: build_invoice_totals
      }.compact_blank
    end

    def build_invoice_entities(entity)
      @nfe_entities[entity].compact_blank.merge(ender_attributes: build_invoice_entity_address(entity))
    end

    def build_invoice_entity_address(entity)
      @nfe_addresses[entity].compact_blank
    end

    def build_invoice_totals
      @nfe_totals.compact_blank
    end

    # def build_invoice_items
    #   @nfe_items.each(&:compact_blank)
    # end
    #
    # def build_invoice_items_totals
    #   @nfe_items_totals.each(&:compact_blank)
    # end
  end
end
