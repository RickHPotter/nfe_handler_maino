# frozen_string_literal: true

# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :document do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, "public", "spec", "assets", "001.xml"), "application/xml") }
  end
end
