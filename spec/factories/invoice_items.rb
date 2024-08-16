# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_items
#
#  id         :bigint           not null, primary key
#  cProd      :string(60)       not null
#  cEAN       :string(14)
#  xProd      :string(120)      not null
#  nCM        :string(8)        not null
#  cFOP       :string(4)        not null
#  uCom       :string(6)        not null
#  qCom       :decimal(15, 4)   not null
#  vUnCom     :decimal(15, 10)  not null
#  vProd      :decimal(15, 2)   not null
#  indTot     :string(1)        not null
#  invoice_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :invoice_item do
    trait :invoice_one_item_one do
      cProd { "BATATAFRITA" }
      cEAN { "SEM GTIN" }
      xProd { "Batata frita" }
      nCM { "02013000" }
      cFOP { "6102" }
      uCom { "BALDE" }
      qCom { 100.0000 }
      vUnCom { 25.0000000000 }
      vProd { 2500.00 }
      indTot { "1" }

      association :invoice, factory: %i[invoice one]
    end

    trait :invoice_one_item_two do
      cProd { "1046475" }
      cEAN { "SEM GTIN" }
      xProd { "Balao estrela" }
      nCM { "34013000" }
      cFOP { "6102" }
      uCom { "UN" }
      qCom { 1.0000 }
      vUnCom { 2.0600000000 }
      vProd { 2.06 }
      indTot { "1" }

      association :invoice, factory: %i[invoice one]
    end
  end
end
