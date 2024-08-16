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
require "rails_helper"

RSpec.describe InvoiceTotal, type: :model do
  let!(:subject) { build(:invoice_total, :invoice_one) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[vBC vNF].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    context "( associations )" do
      %i[invoice].each { |model| it { should belong_to(model) } }
    end
  end
end
