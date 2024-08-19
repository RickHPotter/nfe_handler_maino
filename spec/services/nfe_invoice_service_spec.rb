# frozen_string_literal: true

require "rails_helper"

RSpec.describe Nfe::InvoiceService, type: :service do
  let(:user) { create(:user) }
  let(:document) { create(:document) }
  let(:batch) { create(:batch, total_invoices: 1, user:) }
  let(:xml_content) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "001.xml"), "text/xml").read }
  let(:xml_service) { Xml::NfeExtractionService.new(xml_content) }
  let(:nfe_service) { Nfe::InvoiceService.new(xml_service, user, document.id, batch) }

  def expect_invoice_to_match(invoice:, extracted_xml:)
    invoice_attributes = {
      cUF: invoice.cUF,
      cNF: invoice.cNF,
      mod: invoice.mod,
      serie: invoice.serie,
      nNF: invoice.nNF,
      tpNF: invoice.tpNF,
      dhEmi: invoice.dhEmi.to_datetime
    }.transform_values { |value| value.nil? ? "" : value }

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
    }.transform_values { |value| value.nil? ? "" : value }

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
    }.transform_values { |value| value.nil? ? "" : value }

    expect(entity_address_attributes).to eq(extracted_xml)
  end

  def expect_invoice_total_to_match(invoice_total:, extracted_xml:)
    invoice_total_attributes = {
      vBC: invoice_total.vBC,
      vICMS: invoice_total.vICMS,
      vIPI: invoice_total.vIPI,
      vII: invoice_total.vII,
      vIOF: invoice_total.vIOF,
      vPIS: invoice_total.vPIS,
      vCOFINS: invoice_total.vCOFINS,
      vOutro: invoice_total.vOutro,
      vNF: invoice_total.vNF,
      vTotTrib: invoice_total.vTotTrib
    }.transform_values { |value| value.nil? ? "" : value }

    expect(invoice_total_attributes).to eq(extracted_xml)
  end

  def expect_invoice_items_totals_to_match(invoice_items:, extracted_xml:)
    invoice_items_attributes = invoice_items.map do |invoice_item|
      tot = invoice_item.invoice_item_total
      {
        cProd: invoice_item.cProd,
        cEAN: invoice_item.cEAN,
        xProd: invoice_item.xProd,
        nCM: invoice_item.nCM,
        cFOP: invoice_item.cFOP,
        uCom: invoice_item.uCom,
        qCom: format("%.4f", invoice_item.qCom),
        vUnCom: format("%.10f", invoice_item.vUnCom),
        vProd: format("%.2f", invoice_item.vProd),
        indTot: invoice_item.indTot,
        invoice_item_total_attributes: { vICMS: tot.vICMS, vIPI: tot.vIPI, vII: tot.vII, vIOF: tot.vIOF, vTotTrib: tot.vTotTrib }.transform_values(&:to_f)
      }.transform_values { |value| value.nil? ? "" : value }
    end

    expect(invoice_items_attributes).to match_array(extracted_xml)
  end

  describe "#run" do
    before { nfe_service.run }
    let(:invoice) { Invoice.first }

    it "creates an invoice" do
      expect(Invoice.count).to eq(1)
    end

    it "associates the invoice with the correct user and document" do
      expect(invoice.user).to eq(user)
      expect(invoice.document).to eq(document)
    end

    it "creates invoice with correct details" do
      expect_invoice_to_match(invoice:, extracted_xml: xml_service.extract_invoice_data)
      expect_invoice_to_match(invoice:, extracted_xml: xml_service.extract_invoice_data)
    end

    it "creates invoice entities with correct details" do
      expect_invoice_entity_to_match(invoice_entity: invoice.emit, extracted_xml: xml_service.extract_invoice_entity(:emit))
      expect_invoice_entity_to_match(invoice_entity: invoice.dest, extracted_xml: xml_service.extract_invoice_entity(:dest))
    end

    it "creates entity addresses with correct details" do
      expect_entity_address_to_match(entity_address: invoice.emit.ender, extracted_xml: xml_service.extract_entity_address(:emit))
      expect_entity_address_to_match(entity_address: invoice.dest.ender, extracted_xml: xml_service.extract_entity_address(:dest))
    end

    it "creates invoice totals with correct details" do
      expect_invoice_total_to_match(invoice_total: invoice.invoice_total, extracted_xml: xml_service.extract_invoice_totals)
    end

    it "creates invoice items and invoice items totals with correct details" do
      expect_invoice_items_totals_to_match(invoice_items: invoice.invoice_items, extracted_xml: xml_service.extract_invoice_items)
    end
  end
end
