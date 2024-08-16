# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id           :bigint           not null, primary key
#  cUF          :string(2)        not null
#  cNF          :string(8)        not null
#  mod          :string(2)        not null
#  serie        :string(3)        not null
#  nNF          :string(9)        not null
#  tpNF         :string(1)        not null
#  dhEmi        :datetime         not null
#  processed_at :datetime
#  user_id      :bigint           not null
#  emit_id      :bigint           not null
#  dest_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  document_id  :bigint           not null
#
FactoryBot.define do
  factory :invoice do
    association :user, factory: %i[user random]
    association :document
    association :emit, factory: %i[invoice_entity emit]
    association :dest, factory: %i[invoice_entity dest]

    trait :one do
      cUF { "33" }
      cNF { "05611641" }
      mod { "55" }
      serie { "4" }
      nNF { "500778" }
      tpNF { "1" }
      dhEmi { DateTime.new(2024, 8, 12, 14, 21, 59) }
      processed_at { DateTime.now }
    end

    trait :two do
      cUF { "33" }
      cNF { "05611643" }
      mod { "55" }
      serie { "4" }
      nNF { "500780" }
      tpNF { "1" }
      dhEmi { DateTime.new(2024, 8, 12, 14, 28, 11) }
      processed_at { DateTime.now }
    end

    trait :random do
      cUF { Faker::Number.leading_zero_number(digits: 2) }
      cNF { Faker::Number.leading_zero_number(digits: 8) }
      mod { "55" }
      serie { Faker::Number.number(digits: 1) }
      nNF { Faker::Number.leading_zero_number(digits: 9) }
      tpNF { %w[0 1].sample }
      dhEmi { DateTime.now }
    end
  end
end
