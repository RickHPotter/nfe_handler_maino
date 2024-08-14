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
require "rails_helper"

RSpec.describe EntityAddress, type: :model do
  let!(:subject) { build(:entity_address, :emit) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[xLgr nro xBairro cMun xMun uF cEP].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end
  end
end
