# frozen_string_literal: true

module Zip
  class XmlExtractionService
    require "zip"
    attr_reader :xmls

    def initialize(zip_content)
      @zip = Tempfile.new
      ::File.binwrite(@zip.path, zip_content)
      @xml_files = Zip::File.open(@zip.path).filter { |file| file.name.end_with?(".xml") }
    end

    def extract_all_files
      @xmls = @xml_files.map { |file| file.get_input_stream.read }
    ensure
      @zip.close
      @zip.unlink
    end
  end
end
