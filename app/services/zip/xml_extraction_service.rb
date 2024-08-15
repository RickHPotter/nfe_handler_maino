# frozen_string_literal: true

require "zip"

module Zip
  class XmlExtractionService
    attr_reader :xmls

    def initialize(file)
      @zip = Tempfile.new
      ::File.binwrite(@zip.path, file.read)
    end

    def extract_all_files
      xmls = Zip::File.open(@zip.path).filter do |file|
        file.name.end_with?(".xml")
      end

      @xmls = xmls.map do |file|
        xml = Tempfile.new
        ::File.binwrite(xml.path, file.get_input_stream.read)
        xml
      end
    end
  end
end
