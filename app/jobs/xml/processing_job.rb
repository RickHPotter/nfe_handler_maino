# frozen_string_literal: true

module Xml
  class ProcessingJob < ApplicationJob
    queue_as :default

    def perform(document_id, user)
      document = Document.find(document_id)
      file_content = document.file.download
      file_type = document.file.content_type.split("/").last

      xmls = [ file_content ] if file_type == "xml"
      xmls ||= xmls_from_zip(file_content)

      batch = Batch.create(user:, total_invoices: xmls.count, processed_invoices: 0, finished: false)

      xmls.each { |xml_content| Nfe::InvoiceJob.perform_later(document_id, xml_content, user, batch) }

      batch.update_attribute(:finished, true)

      # user.notifications.create(message: I18n.t("invoices.job.success"))
    rescue StandardError # => e
      # user.notifications.create(message: I18n.t("invoices.job.failed"), body: e.message)
    end

    def xmls_from_zip(file_content)
      zip_service = Zip::XmlExtractionService.new(file_content)
      zip_service.extract_all_files
      zip_service.xmls
    end
  end
end
