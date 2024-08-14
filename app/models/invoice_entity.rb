# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_entities
#
#  id         :bigint           not null, primary key
#  cNPJ       :string(14)       not null
#  xNome      :string(60)       not null
#  xFant      :string(60)
#  IE         :string(14)
#  cRT        :string(1)        not null
#  indIEDest  :string(1)        not null
#  ender_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InvoiceEntity < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :ender, class_name: "EntityAddress"

  # @validations ..............................................................
  validates :cNPJ, :xNome, :indIEDest, presence: true
  validates :cNPJ, uniqueness: true
  validate :cnpj_or_cpf
  validates :xNome, length: { in: 2..60 }
  validates :xFant, length: { maximum: 60 }
  validates :iE, length: { maximum: 14 }
  validates :cRT, length: { is: 1, allow_blank: true }
  validates :indIEDest, length: { is: 1, inclusion: { in: %w[1 2 9] } }

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................

  private

  def cnpj_or_cpf
    return if cNPJ.size.in?([ 11, 14 ])

    errors.add(:cNPJ, "cNPJ ou CPF inválido")
  end
end
