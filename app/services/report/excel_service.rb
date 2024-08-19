# frozen_string_literal: true

require "axlsx"

module Report
  class ExcelService
    CONTENT_TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    COLUMNS = [
      "Modelo", "Serie", "NF", "UF", "CNPJ Emitente", "CNPJ Destinatário", "Data de Emissão", # Invoice
      "Código do Produto", "cEAN", "Nome do Produto", "NCM", "CFOP", "Unidade", "Quantidade", "Valor Unitário", "Valor Total", "indTot", # InvoiceItem
      "Valor ICMS", "Valor IPI", "Valor II", "Valor IOF", "vTotTrib", # InvoiceItemTotal
      "Valor PIS NOTA", "Valor COFINS NOTA" # InvoiceTotal
    ].freeze

    def initialize(batch)
      @batch = batch
      @invoice_items = InvoiceItem.where(invoice_id: batch.invoices.pluck(:id))
    end

    def generate
      package = Axlsx::Package.new
      workbook = package.workbook
      add_det_worksheet(workbook)

      content = package.to_stream.read
      io = StringIO.new(content)
      io.rewind

      document = Document.new
      document.file.attach(io:, filename: "#{DateTime.now}/#{@batch.id}.xlsx", content_type: CONTENT_TYPE)
      @batch.update!(document:)

      package.to_stream.read
    end

    private

    def add_det_worksheet(workbook)
      workbook.add_worksheet(name: "NFe DET") do |sheet|
        sheet.add_row COLUMNS

        @invoice_items.each do |invoice_item|
          invoice = invoice_item.invoice
          total = invoice.invoice_total
          item_total = invoice_item.invoice_item_total

          sheet.add_row [
            *invoice_fields(invoice),
            *invoice_item_fields(invoice_item),
            *invoice_item_total_fields(item_total),
            *invoice_total_fields(total)
          ]
        end
      end
    end

    def invoice_fields(invoice)
      [ invoice.mod,
        invoice.serie,
        invoice.nNF,
        invoice.cUF,
        invoice.emit.cNPJ,
        invoice.dest.cNPJ,
        invoice.dhEmi.strftime("%d/%m/%Y") ]
    end

    def invoice_item_fields(invoice_item)
      [ invoice_item.cProd,
        invoice_item.cEAN,
        invoice_item.xProd,
        invoice_item.nCM,
        invoice_item.cFOP,
        invoice_item.uCom,
        invoice_item.qCom,
        invoice_item.vUnCom,
        invoice_item.vProd,
        invoice_item.indTot ]
    end

    def invoice_item_total_fields(invoice_item_total)
      [ invoice_item_total.vICMS,
        invoice_item_total.vIPI,
        invoice_item_total.vII,
        invoice_item_total.vIOF,
        invoice_item_total.vTotTrib ]
    end

    def invoice_total_fields(invoice_total)
      [ invoice_total.vPIS,
        invoice_total.vCOFINS ]
    end
  end
end
