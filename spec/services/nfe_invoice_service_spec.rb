# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nfe::InvoiceService, type: :service do
  let(:user) { create(:user) }
  let(:document) { create(:document) }
  let(:xml_content) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "001.xml"), "text/xml").read }
  let(:xml_service) { Xml::NfeExtractionService.new(xml_content) }
  let(:nfe_service) { described_class.new(xml_service, user, document.id) }

  def expect_invoice_to_match(invoice:, extracted_xml:)
    invoice_attributes = {
      cUF: invoice.cUF,
      cNF: invoice.cNF,
      mod: invoice.mod,
      serie: invoice.serie,
      nNF: invoice.nNF,
      tpNF: invoice.tpNF,
      dhEmi: invoice.dhEmi.to_datetime
    }

    invoice_attributes.each { |k, v| invoice_attributes[k] = "" if v.nil? }

    expect(invoice_attributes).to eq(extracted_xml)
  end

  def expect_invoice_entity_to_match(invoice_entity:, extracted_xml:)
    invoice_entity_attributes = {
      cNPJ: invoice_entity.cNPJ,
      xNome: invoice_entity.xNome,
      xFant: invoice_entity.xFant,
      iE: invoice_entity.iE,
      cRT: invoice_entity.cRT,
      indIEDest: invoice_entity.indIEDest
    }

    invoice_entity_attributes.each { |k, v| invoice_entity_attributes[k] = "" if v.nil? }

    expect(invoice_entity_attributes).to eq(extracted_xml)
  end

  def expect_entity_address_to_match(entity_address:, extracted_xml:)
    entity_address_attributes = {
      xLgr: entity_address.xLgr,
      nro: entity_address.nro,
      xCpl: entity_address.xCpl,
      xBairro: entity_address.xBairro,
      cMun: entity_address.cMun,
      xMun: entity_address.xMun,
      uF: entity_address.uF,
      cEP: entity_address.cEP,
      cPais: entity_address.cPais,
      xPais: entity_address.xPais,
      fone: entity_address.fone
    }

    entity_address_attributes.each { |k, v| entity_address_attributes[k] = "" if v.nil? }

    expect(entity_address_attributes).to eq(extracted_xml)
  end

  describe "#run" do
    before { nfe_service.run }

    it "creates an invoice" do
      expect(Invoice.count).to eq(1)
    end

    it "associates the invoice with the correct user and document" do
      invoice = Invoice.first

      expect(invoice.user).to eq(user)
      expect(invoice.document).to eq(document)
    end

    it "creates invoice with correct details" do
      invoice = Invoice.first

      expect_invoice_to_match(invoice:, extracted_xml: xml_service.extract_invoice_data)
      expect_invoice_to_match(invoice:, extracted_xml: xml_service.extract_invoice_data)
    end

    it "creates invoice entities with correct details" do
      invoice = Invoice.first

      expect_invoice_entity_to_match(invoice_entity: invoice.emit, extracted_xml: xml_service.extract_invoice_entity(:emit))
      expect_invoice_entity_to_match(invoice_entity: invoice.dest, extracted_xml: xml_service.extract_invoice_entity(:dest))
    end

    it "creates entity addresses with correct details" do
      invoice = Invoice.first

      expect_entity_address_to_match(entity_address: invoice.emit.ender, extracted_xml: xml_service.extract_invoice_address(:emit))
      expect_entity_address_to_match(entity_address: invoice.dest.ender, extracted_xml: xml_service.extract_invoice_address(:dest))
    end
  end
end
