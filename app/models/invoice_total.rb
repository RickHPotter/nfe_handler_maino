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
  # @public_instance_methods ..................................................
  def tax_total
    vICMS + vIPI + vPIS + vCOFINS + vII + vIOF + vOutro
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
