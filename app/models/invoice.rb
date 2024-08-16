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
class Invoice < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :user
  belongs_to :document
  belongs_to :emit, class_name: "InvoiceEntity"
  belongs_to :dest, class_name: "InvoiceEntity"

  has_one :invoice_total
  has_many :invoice_items

  # @validations ..............................................................
  validates :cUF, :cNF, :mod, :serie, :nNF, :dhEmi, :tpNF, presence: true
  validates :cUF, length: { maximum: 2 }
  validates :cNF, length: { maximum: 8 }
  validates :mod, length: { maximum: 2 }
  validates :serie, length: { in: 1..3 }
  validates :nNF, length: { in: 1..9 }
  validates :tpNF, length: { is: 1, inclusion: { in: %w[0 1] } }

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
