# frozen_string_literal: true

module Xml
  class ProcessingJob < ApplicationJob
    queue_as :default

    def perform(file_content, file_type, user)
      file_content = Base64.decode64(file_content)

      xmls = [ file_content ] if file_type == "xml"
      xmls ||= xmls_from_zip(file_content)

      xmls.each { |xml_content| Nfe::InvoiceJob.perform_later(xml_content, user) }

      # user.notifications.create(message: "Your invoice has been processed.")
    end

    def xmls_from_zip(file_content)
      zip_service = Zip::XmlExtractionService.new(file_content)
      zip_service.extract_all_files
      zip_service.xmls
    end
  end
end
