# frozen_string_literal: true

require "rails_helper"
require "zip"

RSpec.describe Zip::XmlExtractionService, type: :service do
  let(:zip_file) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "zip.zip"), "application/zip") }
  let(:zip_content) { zip_file.read }
  let(:service) { described_class.new(zip_content) }

  describe "#extract_all_files" do
    it "extracts the only two XML files from the zip" do
      service.extract_all_files
      expect(service.xmls.size).to eq(2)
    end
  end

  describe "cleanup" do
    it "closes and unlinks the tempfile" do
      expect(service.instance_variable_get(:@zip)).to receive(:close).and_call_original
      expect(service.instance_variable_get(:@zip)).to receive(:unlink).and_call_original

      service.extract_all_files
    end
  end
end
