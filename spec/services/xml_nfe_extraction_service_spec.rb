# frozen_string_literal: true

require "rails_helper"

RSpec.describe Xml::NfeExtractionService, type: :service do
  let(:xml_file) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "001.xml"), "text/xml") }
  let(:xml_content) { File.read(xml_file) }
  let(:service) { described_class.new(xml_content) }

  let(:invoice_data) { build(:invoice, :one) }
  let(:sender_data) { build(:invoice_entity, :emit) }
  let(:address_data) { build(:entity_address, :emit) }
  let(:invoice_total) { build(:invoice_total, :invoice_one) }

  describe "#extract_invoice_data" do
    it "correctly extracts the invoice data from the XML" do
      extracted_data = service.extract_invoice_data
      extracted_data[:dhEmi] = extracted_data[:dhEmi].to_datetime

      expect(extracted_data).to eq(
        cUF: invoice_data.cUF,
        cNF: invoice_data.cNF,
        mod: invoice_data.mod,
        serie: invoice_data.serie,
        nNF: invoice_data.nNF,
        tpNF: invoice_data.tpNF,
        dhEmi: invoice_data.dhEmi
      )
    end
  end

  describe "#extract_invoice_entity" do
    it "correctly extracts the invoice entity data from the XML" do
      extracted_data = service.extract_invoice_entity(:emit)
      expect(extracted_data).to eq(
        cNPJ: sender_data.cNPJ,
        xNome: sender_data.xNome,
        xFant: sender_data.xFant,
        iE: sender_data.iE,
        cRT: sender_data.cRT,
        indIEDest: sender_data.indIEDest
      )
    end
  end

  describe "#extract_invoice_address" do
    it "correctly extracts the invoice address data from the XML" do
      extracted_data = service.extract_invoice_address(:emit)
      expect(extracted_data).to eq(
        xLgr: address_data.xLgr,
        nro: address_data.nro,
        xCpl: address_data.xCpl,
        xBairro: address_data.xBairro,
        cMun: address_data.cMun,
        xMun: address_data.xMun,
        uF: address_data.uF,
        cEP: address_data.cEP,
        cPais: address_data.cPais,
        xPais: address_data.xPais,
        fone: address_data.fone
      )
    end
  end

  describe "#extract_invoice_totals" do
    it "correctly extracts the invoice totals data from the XML" do
      extracted_data = service.extract_invoice_totals
      expect(extracted_data).to eq({
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
      }.transform_values(&:to_f))
    end
  end
end
