# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_addresses
#
#  id         :bigint           not null, primary key
#  xLgr       :string(60)       not null
#  nro        :string(60)       not null
#  xCpl       :string(60)
#  xBairro    :string(60)       not null
#  cMun       :string(7)        not null
#  xMun       :string(60)       not null
#  uF         :string(2)        not null
#  cEP        :string(8)        not null
#  cPais      :string(4)        not null
#  xPais      :string(60)       not null
#  fone       :string(14)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EntityAddress < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  # @validations ..............................................................
  validates :xLgr, :nro, :xBairro, :cMun, :xMun, :uF, :cEP, presence: true
  validates :xLgr, :xBairro, :xMun, length: { within: 2..60 }
  validates :nro, length: { within: 1..60 }
  validates :xPais, :xCpl, length: { maximum: 60 }
  validates :cMun, length: { maximum: 7 }
  validates :uF, length: { is: 2 }
  validates :cEP, length: { is: 8 }
  validates :cPais, length: { maximum: 4 }
  validates :fone, length: { minimum: 7, maximum: 14, allow_blank: true }

  # @callbacks ................................................................
  before_validation :fill_in_country

  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  def fill_in_country
    self.cPais = "1058"
    self.xPais = "BRASIL"
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
