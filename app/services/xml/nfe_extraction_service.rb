# frozen_string_literal: true

module Xml
  class NfeExtractionService
    attr_reader :xml

    def initialize(xml_content)
      @xml = Nokogiri::XML(xml_content)
      @ide = @xml.xpath("//xmlns:ide")
      @emit = @xml.xpath("//xmlns:emit")
      @dest = @xml.xpath("//xmlns:dest")

      @emit_address = @emit.xpath("./xmlns:enderEmit")
      @dest_address = @dest.xpath("./xmlns:enderDest")

      @items = @xml.xpath("//xmlns:det")
      @total = @xml.xpath("//xmlns:total/xmlns:ICMSTot")
    end

    def extract_invoice_data
      {
        cUF: @ide.xpath("./xmlns:cUF"),
        cNF: @ide.xpath("./xmlns:cNF"),
        mod: @ide.xpath("./xmlns:mod"),
        serie: @ide.xpath("./xmlns:serie"),
        nNF: @ide.xpath("./xmlns:nNF"),
        tpNF: @ide.xpath("./xmlns:tpNF"),
        dhEmi: @ide.xpath("./xmlns:dhEmi")
      }.transform_values(&:text)
    end

    def extract_invoice_entity(entity)
      entity = entity == :emit ? @emit : @dest
      {
        cNPJ: entity.xpath("./xmlns:CNPJ"),
        xNome: entity.xpath("./xmlns:xNome"),
        xFant: entity.xpath("./xmlns:xFant"),
        iE: entity.xpath("./xmlns:IE"),
        cRT: entity.xpath("./xmlns:CRT"),
        indIEDest: entity.xpath("./xmlns:indIEDest")
      }.transform_values(&:text)
    end

    def extract_entity_address(entity)
      address = entity == :emit ? @emit_address : @dest_address
      {
        xLgr: address.xpath("./xmlns:xLgr"),
        nro: address.xpath("./xmlns:nro"),
        xCpl: address.xpath("./xmlns:xCpl"),
        xBairro: address.xpath("./xmlns:xBairro"),
        cMun: address.xpath("./xmlns:cMun"),
        xMun: address.xpath("./xmlns:xMun"),
        uF: address.xpath("./xmlns:UF"),
        cEP: address.xpath("./xmlns:CEP"),
        cPais: address.xpath("./xmlns:cPais"),
        xPais: address.xpath("./xmlns:xPais"),
        fone: address.xpath("./xmlns:fone")
      }.transform_values(&:text)
    end

    def extract_invoice_items
      @items.map do |item|
        {
          cProd: item.xpath(".//xmlns:cProd"),
          cEAN: item.xpath(".//xmlns:cEAN"),
          xProd: item.xpath(".//xmlns:xProd"),
          nCM: item.xpath(".//xmlns:NCM"),
          cFOP: item.xpath(".//xmlns:CFOP"),
          uCom: item.xpath(".//xmlns:uCom"),
          qCom: item.xpath(".//xmlns:qCom"),
          vUnCom: item.xpath(".//xmlns:vUnCom"),
          vProd: item.xpath(".//xmlns:vProd"),
          indTot: item.xpath(".//xmlns:indTot")
        }.transform_values(&:text).merge(invoice_item_total_attributes: extract_invoice_item_totals(item))
      end
    end

    def extract_invoice_item_totals(item)
      {
        vICMS: item.xpath("./xmlns:imposto/xmlns:ICMS//xmlns:vICMS"),
        vIPI: item.xpath("./xmlns:imposto/xmlns:IPI//xmlns:vIPI"),
        vII: item.xpath("./xmlns:imposto/xmlns:II/xmlns:vII"),
        vIOF: item.xpath("./xmlns:imposto/xmlns:II/xmlns:vIOF"),
        vTotTrib: item.xpath("./xmlns:imposto//xmlns:vTotTrib")
      }.transform_values { |value| value.text.to_f }
    end

    def extract_invoice_totals
      {
        vBC: @total.xpath("./xmlns:vBC"),
        vICMS: @total.xpath("./xmlns:vICMS"),
        vIPI: @total.xpath("./xmlns:vIPI"),
        vII: @total.xpath("./xmlns:vII"),
        vIOF: @total.xpath("./xmlns:vIOF"),
        vPIS: @total.xpath("./xmlns:vPIS"),
        vCOFINS: @total.xpath("./xmlns:vCOFINS"),
        vOutro: @total.xpath("./xmlns:vOutro"),
        vNF: @total.xpath("./xmlns:vNF"),
        vTotTrib: @total.xpath("./xmlns:vTotTrib")
      }.transform_values { |value| value.text.to_f }
    end
  end
end
