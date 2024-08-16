# frozen_string_literal: true

module Nfe
  class InvoiceJob < ApplicationJob
    queue_as :default

    def perform(document_id, file_content, user)
      xml_service = Xml::NfeExtractionService.new(file_content)
      nfe_service = Nfe::InvoiceService.new(xml_service, user, document_id)
      nfe_service.run
    end
  end
end
