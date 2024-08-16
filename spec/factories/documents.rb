# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, "public", "spec", "assets", "001.xml"), "application/xml") }
  end
end
