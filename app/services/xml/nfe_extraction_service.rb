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

    def extract_invoice_address(entity)
      head = "//xmlns:#{entity}/xmlns:ender#{entity.capitalize}/xmlns"
      {
        xLgr: @xml.xpath("#{head}:xLgr").text,
        nro: @xml.xpath("#{head}:nro").text,
        xCpl: @xml.xpath("#{head}:xCpl").text,
        xBairro: @xml.xpath("#{head}:xBairro").text,
        cMun: @xml.xpath("#{head}:cMun").text,
        xMun: @xml.xpath("#{head}:xMun").text,
        uF: @xml.xpath("#{head}:UF").text,
        cEP: @xml.xpath("#{head}:CEP").text,
        cPais: @xml.xpath("#{head}:cPais").text,
        xPais: @xml.xpath("#{head}:xPais").text,
        fone: @xml.xpath("#{head}:fone").text
      }
    end

    # def extract_invoice_items
    # end
    #
    # def extract_invoice_item_totals
    # end

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
