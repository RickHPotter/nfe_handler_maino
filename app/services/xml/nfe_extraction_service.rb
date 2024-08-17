# frozen_string_literal: true

module Xml
  class NfeExtractionService
    attr_reader :xml

    def initialize(xml_content)
      @xml = Nokogiri::XML(xml_content)
    end

    def extract_invoice_data
      {
        cUF: @xml.xpath("//xmlns:ide/xmlns:cUF").text,
        cNF: @xml.xpath("//xmlns:ide/xmlns:cNF").text,
        mod: @xml.xpath("//xmlns:ide/xmlns:mod").text,
        serie: @xml.xpath("//xmlns:ide/xmlns:serie").text,
        nNF: @xml.xpath("//xmlns:ide/xmlns:nNF").text,
        tpNF: @xml.xpath("//xmlns:ide/xmlns:tpNF").text,
        dhEmi: @xml.xpath("//xmlns:ide/xmlns:dhEmi").text
      }
    end

    def extract_invoice_entity(entity)
      head = "//xmlns:#{entity}/xmlns"
      {
        cNPJ: @xml.xpath("#{head}:CNPJ").text,
        xNome: @xml.xpath("#{head}:xNome").text,
        xFant: @xml.xpath("#{head}:xFant").text,
        iE: @xml.xpath("#{head}:IE").text,
        cRT: @xml.xpath("#{head}:CRT").text,
        indIEDest: @xml.xpath("#{head}:indIEDest").text
      }
    end

    def extract_entity_address(entity)
      head = "//xmlns:#{entity}/xmlns:ender#{entity.capitalize}/xmlns"
      {
        xLgr: @xml.xpath("#{head}:xLgr"),
        nro: @xml.xpath("#{head}:nro"),
        xCpl: @xml.xpath("#{head}:xCpl"),
        xBairro: @xml.xpath("#{head}:xBairro"),
        cMun: @xml.xpath("#{head}:cMun"),
        xMun: @xml.xpath("#{head}:xMun"),
        uF: @xml.xpath("#{head}:UF"),
        cEP: @xml.xpath("#{head}:CEP"),
        cPais: @xml.xpath("#{head}:cPais"),
        xPais: @xml.xpath("#{head}:xPais"),
        fone: @xml.xpath("#{head}:fone")
      }.transform_values(&:text)
    end

    def extract_invoice_items
      @xml.xpath("//xmlns:det").map do |item|
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
        }.transform_values(&:text)
          .merge(invoice_item_total_attributes: extract_invoice_item_totals(item))
      end
    end

    def extract_invoice_item_totals(item)
      {
        vICMS: item.xpath(".//xmlns:imposto/xmlns:ICMS//xmlns:vICMS"),
        vIPI: item.xpath(".//xmlns:imposto/xmlns:IPI//xmlns:vIPI"),
        vII: item.xpath(".//xmlns:imposto/xmlns:II/xmlns:vII"),
        vIOF: item.xpath(".//xmlns:imposto/xmlns:II/xmlns:vIOF"),
        vTotTrib: item.xpath(".//xmlns:imposto//xmlns:vTotTrib")
      }.transform_values { |value| value.text.to_f }
    end

    def extract_invoice_totals
      {
        vBC: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vBC"),
        vICMS: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vICMS"),
        vIPI: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vIPI"),
        vII: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vII"),
        vIOF: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vIOF"),
        vPIS: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vPIS"),
        vCOFINS: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vCOFINS"),
        vOutro: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vOutro"),
        vNF: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vNF"),
        vTotTrib: @xml.xpath("//xmlns:total/xmlns:ICMSTot/xmlns:vTotTrib")
      }.transform_values { |value| value.text.to_f }
    end
  end
end
