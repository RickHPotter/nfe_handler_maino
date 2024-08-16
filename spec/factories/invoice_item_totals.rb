# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_item_totals
#
#  id              :bigint           not null, primary key
#  vICMS           :decimal(15, 2)   default(0.0), not null
#  vIPI            :decimal(15, 2)   default(0.0), not null
#  vII             :decimal(15, 2)   default(0.0), not null
#  vIOF            :decimal(15, 2)   default(0.0), not null
#  vTotTrib        :decimal(15, 2)   default(0.0), not null
#  invoice_item_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :invoice_item_total do
    trait :invoice_one_item_one do
      vICMS { 330.00 }
      vIPI { 250.00 }
      vII { 0.00 }
      vIOF { 0.00 }
      vTotTrib { 405.00 }

      association :invoice_item, factory: %i[invoice_item invoice_one_item_one]
    end

    trait :invoice_one_item_two do
      vICMS { 0.25 }
      vIPI { 0.00 }
      vII { 0.00 }
      vIOF { 0.00 }
      vTotTrib { 0.00 }

      association :invoice_item, factory: %i[invoice_item invoice_one_item_two]
    end
  end
end
