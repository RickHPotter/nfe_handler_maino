# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_addresses
#
#  id         :bigint           not null, primary key
#  xLgr       :string(60)       not null
#  nro        :string(60)       not null
#  xCpl       :string(60)
#  xBairro    :string(60)       not null
#  cMun       :string(7)        not null
#  xMun       :string(60)       not null
#  uF         :string(2)        not null
#  cEP        :string(8)        not null
#  cPais      :string(4)        not null
#  xPais      :string(60)       not null
#  fone       :string(14)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :entity_address do
    trait :emit do
      xLgr { "RUA MARCOS MORO" }
      nro { "16" }
      xCpl { "SL 808" }
      xBairro { "SAO FRANCISCO" }
      cMun { "3304557" }
      xMun { "RIO DE JANEIRO" }
      uF { "RJ" }
      cEP { "80530080" }
      cPais { "1058" }
      xPais { "BRASIL" }
      fone { "211234567899" }
    end

    trait :dest do
      xLgr { "Rua Augusta, 50" }
      nro { "50" }
      xBairro { "Consolacao" }
      cMun { "3550308" }
      xMun { "SAO PAULO" }
      uF { "SP" }
      cEP { "01305901" }
      cPais { "1058" }
      xPais { "BRASIL" }
    end
  end
end
