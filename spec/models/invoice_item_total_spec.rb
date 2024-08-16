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
require "rails_helper"

RSpec.describe InvoiceItemTotal, type: :model do
  let!(:subject) { build(:invoice_item_total, :invoice_one_item_one) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
    end

    context "( associations )" do
      %i[invoice_item].each { |model| it { should belong_to(model) } }
    end
  end
end
