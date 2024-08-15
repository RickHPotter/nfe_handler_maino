# frozen_string_literal: true

module Nfe
  class InvoiceJob < ApplicationJob
    queue_as :default

    def perform(file_content, user)
      xml_service = Xml::NfeExtractionService.new(file_content)
      nfe_service = Nfe::InvoiceService.new(xml_service, user)
      nfe_service.run
    end
  end
end
