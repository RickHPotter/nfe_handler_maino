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
  MOD = { "55": "NFe", "65": "NFCe" }.freeze
  TPNF = { "0": "Entrada", "1": "Saída" }.freeze
  UF = { "11": "Rondônia - RO",
         "12": "Acre - AC",
         "13": "Amazonas - AM",
         "14": "Roraima - RR",
         "15": "Pará - PA",
         "16": "Amapá - AP",
         "17": "Tocantins - TO",
         "21": "Maranhão - MA",
         "22": "Piauí - PI",
         "23": "Ceará - CE",
         "24": "Rio Grande do Norte - RN",
         "25": "Paraíba - PB",
         "26": "Pernambuco - PE",
         "27": "Alagoas - AL",
         "28": "Sergipe - SE",
         "29": "Bahia - BA",
         "31": "Minas Gerais - MG",
         "32": "Espírito Santo - ES",
         "33": "Rio de Janeiro - RJ",
         "35": "São Paulo - SP",
         "41": "Paraná - PR",
         "42": "Santa Catarina - SC",
         "43": "Rio Grande do Sul - RS",
         "50": "Mato Grosso do Sul - MS",
         "51": "Mato Grosso - MT",
         "52": "Goiás - GO",
         "53": "Distrito Federal - DF" }.freeze
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :user
  belongs_to :document
  belongs_to :emit, class_name: "InvoiceEntity"
  belongs_to :dest, class_name: "InvoiceEntity"

  has_one :invoice_total, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :invoice_batches, dependent: :destroy
  has_many :batches, through: :invoice_batches

  accepts_nested_attributes_for :emit
  accepts_nested_attributes_for :dest
  accepts_nested_attributes_for :invoice_total
  accepts_nested_attributes_for :invoice_items

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
  def model_label
    "#{mod} - #{MOD[mod.to_sym]}"
  end

  def tipo_nf_label
    "#{tpNF} - #{TPNF[tpNF.to_sym]}"
  end

  def uf_label
    "[#{cUF}] #{UF[cUF.to_sym]}"
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
