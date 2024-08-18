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
class InvoiceTotal < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :invoice

  # @validations ..............................................................
  validates :vBC, :vNF, presence: true
  validates :vBC, :vICMS, :vIPI, :vII, :vIOF, :vPIS, :vCOFINS, :vOutro, :vNF, :vTotTrib,
            numericality: true, allow_nil: true

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  def self.from_ids(ids)
    invoice_totals = where(id: ids)
    new(vBC: invoice_totals.sum(:vBC),
        vICMS: invoice_totals.sum(:vICMS),
        vIPI: invoice_totals.sum(:vIPI),
        vII: invoice_totals.sum(:vII),
        vIOF: invoice_totals.sum(:vIOF),
        vPIS: invoice_totals.sum(:vPIS),
        vCOFINS: invoice_totals.sum(:vCOFINS),
        vOutro: invoice_totals.sum(:vOutro),
        vNF: invoice_totals.sum(:vNF),
        vTotTrib: invoice_totals.sum(:vTotTrib))
  end

  # @public_instance_methods ..................................................
  def tax_total
    vICMS + vIPI + vPIS + vCOFINS + vII + vIOF + vOutro
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
