# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_totals
#
#  id         :bigint           not null, primary key
#  vBC        :decimal(15, 2)   not null
#  vICMS      :decimal(15, 2)   default(0.0), not null
#  vIPI       :decimal(15, 2)   default(0.0), not null
#  vII        :decimal(15, 2)   default(0.0), not null
#  vIOF       :decimal(15, 2)   default(0.0), not null
#  vPIS       :decimal(15, 2)   default(0.0), not null
#  vCOFINS    :decimal(15, 2)   default(0.0), not null
#  vOutro     :decimal(15, 2)   default(0.0), not null
#  vNF        :decimal(15, 2)   not null
#  vTotTrib   :decimal(15, 2)   default(0.0), not null
#  invoice_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :invoice_total do
    trait :invoice_one do
      vBC { 2752.06 }
      vICMS { 330.25 }
      vIPI { 250.00 }
      vII { 0.00 }
      vIOF { 0.00 }
      vPIS { 0.00 }
      vCOFINS { 0.00 }
      vOutro { 0.00 }
      vNF { 2752.06 }
      vTotTrib { 405.00 }

      association :invoice, factory: %i[invoice one]
    end
  end
end
