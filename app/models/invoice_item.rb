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
class InvoiceItem < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :invoice

  has_one :invoice_item_total

  accepts_nested_attributes_for :invoice_item_total

  # @validations ..............................................................
  validates :cProd, :cEAN, :xProd, :nCM, :cFOP, :uCom, :qCom, :vUnCom, :vProd, :indTot, presence: true
  validates :cProd, length: { maximum: 60 }
  validates :cEAN, length: { maximum: 14 }
  validates :xProd, length: { maximum: 120 }
  validates :nCM, length: { maximum: 8 }
  validates :cFOP, length: { maximum: 4 }
  validates :uCom, length: { maximum: 6 }
  validates :qCom, :vUnCom, :vProd, :indTot, numericality: true

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
