# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id           :bigint           not null, primary key
#  cUF          :string(2)        not null
#  cNF          :string(8)        not null
#  mod          :string(2)        not null
#  serie        :string(3)        not null
#  nNF          :string(9)        not null
#  tpNF         :string(1)        not null
#  dhEmi        :datetime         not null
#  processed_at :datetime
#  user_id      :bigint           not null
#  emit_id      :bigint           not null
#  dest_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  document_id  :bigint           not null
#
require "rails_helper"

RSpec.describe Invoice, type: :model do
  let!(:subject) { build(:invoice, :one) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[cUF cNF mod serie nNF tpNF dhEmi].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    context "( associations )" do
      %i[user document emit dest].each { |model| it { should belong_to(model) } }
    end
  end
end
