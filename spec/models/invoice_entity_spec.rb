# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_entities
#
#  id         :bigint           not null, primary key
#  cNPJ       :string(14)       not null
#  xNome      :string(60)       not null
#  xFant      :string(60)
#  iE         :string(14)
#  cRT        :string(1)
#  indIEDest  :string(1)
#  ender_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe InvoiceEntity, type: :model do
  let!(:subject) { build(:invoice_entity, :emit) }

  describe "[ activerecord validations ]" do
    context "( presence, uniqueness, etc )" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      %i[cNPJ xNome].each do |attribute|
        it { should validate_presence_of(attribute) }
      end
    end

    context "( associations )" do
      %i[ender].each { |model| it { should belong_to(model) } }
    end
  end
end
