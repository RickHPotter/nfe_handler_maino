# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_entities
#
#  id         :bigint           not null, primary key
#  cNPJ       :string(14)       not null
#  xNome      :string(60)       not null
#  xFant      :string(60)
#  IE         :string(14)
#  cRT        :string(1)        not null
#  indIEDest  :string(1)        not null
#  ender_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :invoice_entity do
    trait :emit do
      cNPJ { "60124452000107" }
      xNome { "MAINO SISTEMAS DE INFORMATICA LTD" }
      xFant { "MAINO SISTEMAS" }
      iE { "78205377" }
      cRT { "3" }
      indIEDest { "1" }

      association :ender, factory: %i[entity_address emit]
    end

    trait :dest do
      cNPJ { "08370779000149" }
      xNome { "MAINO CLIENTE" }
      indIEDest { "9" }

      association :ender, factory: %i[entity_address dest]
    end
  end
end
