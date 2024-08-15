# frozen_string_literal: true

module Nfe
  class InvoiceService
    attr_reader :invoice

    def initialize(extracted_nfe, current_user)
      @nfe = extracted_nfe
      @current_user = current_user

      @nfe_data = extracted_nfe.extract_invoice_data
      @nfe_entities = { emit: extracted_nfe.extract_invoice_entity(:emit), dest: extracted_nfe.extract_invoice_entity(:dest) }
      @nfe_addresses = { emit: extracted_nfe.extract_invoice_address(:emit), dest: extracted_nfe.extract_invoice_address(:dest) }
    end

    def run
      invoice_emit_address = build_invoice_entity_address(:emit)
      invoice_dest_address = build_invoice_entity_address(:dest)

      invoice_emit_entity = build_invoice_entities(:emit)
      invoice_dest_entity = build_invoice_entities(:dest)

      ActiveRecord::Base.transaction do
        emit_address = EntityAddress.create!(invoice_emit_address)
        dest_address = EntityAddress.create!(invoice_dest_address)

        emit = InvoiceEntity.create!(invoice_emit_entity.merge(ender: emit_address))
        dest = InvoiceEntity.create!(invoice_dest_entity.merge(ender: dest_address))

        @invoice = Invoice.create!(build_invoice.merge(emit:, dest:))
      end
    end

    private

    def build_invoice_entity_address(entity)
      {
        xLgr: @nfe_addresses[entity][:xLgr],
        nro: @nfe_addresses[entity][:nro],
        xCpl: @nfe_addresses[entity][:xCpl],
        xBairro: @nfe_addresses[entity][:xBairro],
        cMun: @nfe_addresses[entity][:cMun],
        xMun: @nfe_addresses[entity][:xMun],
        uF: @nfe_addresses[entity][:uF],
        cEP: @nfe_addresses[entity][:cEP],
        cPais: @nfe_addresses[entity][:cPais],
        xPais: @nfe_addresses[entity][:xPais],
        fone: @nfe_addresses[entity][:fone]
      }.compact_blank
    end

    def build_invoice_entities(entity)
      {
        cNPJ: @nfe_entities[entity][:cNPJ],
        xNome: @nfe_entities[entity][:xNome],
        xFant: @nfe_entities[entity][:xFant],
        iE: @nfe_entities[entity][:IE],
        cRT: @nfe_entities[entity][:cRT],
        indIEDest: @nfe_entities[entity][:indIEDest]
      }.compact_blank
    end

    def build_invoice
      {
        cUF: @nfe_data[:cUF],
        cNF: @nfe_data[:cNF],
        mod: @nfe_data[:mod],
        serie: @nfe_data[:serie],
        nNF: @nfe_data[:nNF],
        tpNF: @nfe_data[:tpNF],
        dhEmi: @nfe_data[:dhEmi],
        user_id: @current_user.id,
        processed_at: DateTime.current
      }.compact_blank
    end
  end
end
