# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id                 :bigint           not null, primary key
#  description        :string
#  total_invoices     :integer          not null
#  processed_invoices :integer          not null
#  finished           :boolean          default(FALSE), not null
#  user_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :batch do
    total_invoices { Faker::Number.between(from: 2, to: 100) }
    processed_invoices { 0 }
    finished { false }

    user
  end
end
