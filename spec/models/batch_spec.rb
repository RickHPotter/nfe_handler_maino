# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id                 :bigint           not null, primary key
#  description        :string
#  total_invoices     :integer          not null
#  processed_invoices :integer          not null
#  finished           :boolean          default(FALSE), not null
#  user_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "rails_helper"

RSpec.describe Batch, type: :model do
  let!(:subject) { build(:batch) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[total_invoices processed_invoices].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    context "( associations )" do
      %i[user].each { |model| it { should belong_to(model) } }

      %i[invoice_batches invoices].each { |model| it { should have_many(model) } }
    end
  end
end
