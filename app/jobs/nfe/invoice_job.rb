# frozen_string_literal: true

module Nfe
  class InvoiceJob < ApplicationJob
    queue_as :default

    def perform(document_id, file_content, user, batch)
      xml_service = Xml::NfeExtractionService.new(file_content)
      nfe_service = Nfe::InvoiceService.new(xml_service, user, document_id, batch)
      nfe_service.run
    end
  end
end
