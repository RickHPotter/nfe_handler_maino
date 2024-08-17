# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_batches
#
#  id         :bigint           not null, primary key
#  invoice_id :bigint           not null
#  batch_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :invoice_batch do
    association :invoice, factory: %i[invoice one]
    association :batch, factory: :batch
  end
end
