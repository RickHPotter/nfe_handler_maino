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
require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  let!(:subject) { build(:invoice_item, :invoice_one_item_one) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[cProd xProd nCM cFOP uCom qCom vUnCom vProd indTot].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    context "( associations )" do
      %i[invoice].each { |model| it { should belong_to(model) } }
    end
  end
end
