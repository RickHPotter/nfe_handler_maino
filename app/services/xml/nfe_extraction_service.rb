# frozen_string_literal: true

module Xml
  class NfeExtractionService
    def initialize(file: nil, xml: nil)
      if file && xml.nil?
        xml = Tempfile.new
        File.binwrite(xml.path, file.read)
      end

      @xml = Nokogiri::XML(xml)
    ensure
      xml.close
      xml.unlink
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
  end
end
