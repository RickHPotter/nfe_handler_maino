# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_batches
#
#  id         :bigint           not null, primary key
#  invoice_id :bigint           not null
#  batch_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe InvoiceBatch, type: :model do
  let!(:subject) { build(:invoice_batch) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
    end

    context "( associations )" do
      %i[invoice batch].each { |model| it { should belong_to(model) } }
    end
  end
end
